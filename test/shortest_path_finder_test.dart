import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/core/algorithms/shortest_path_finder.dart';
import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';

/// Top-level wrapper so the finder can run through `compute`.
Map<String, dynamic> solveLargeField(Map<String, dynamic> args) {
  final field = (args['field'] as List).cast<String>();
  final start = args['start'] as Map<String, dynamic>;
  final end = args['end'] as Map<String, dynamic>;

  final grid = Grid(field);
  const finder = ShortestPathFinder(SlidingMovement());
  final path = finder.find(
    grid,
    Point(start['x'] as int, start['y'] as int),
    Point(end['x'] as int, end['y'] as int),
  );

  return {
    'steps': path?.map((p) => {'x': p.x, 'y': p.y}).toList(),
  };
}

void main() {
  test('task case: (1,2) -> (2,1) -> (2,0)', () {
    final grid = Grid(['...', '.X.', '..X']);
    const finder = ShortestPathFinder(SlidingMovement());

    final path = finder.find(grid, const Point(1, 2), const Point(2, 0));

    expect(path, isNotNull);
    expect(path!, hasLength(3));
    expect(path.first, const Point(1, 2));
    expect(path[1], const Point(2, 1));
    expect(path.last, const Point(2, 0));
  });

  test('live API case reaches end via diagonal then left', () {
    final grid = Grid(['.X.', '.X.', '...']);
    const finder = ShortestPathFinder(SlidingMovement());

    final path = finder.find(grid, const Point(2, 1), const Point(0, 2));

    expect(path, isNotNull);
    expect(path!, hasLength(3));
    expect(path.first, const Point(2, 1));
    expect(path[1], const Point(1, 2));
    expect(path.last, const Point(0, 2));
  });

  test('impassable field returns null', () {
    final grid = Grid(['..X..', '..X..', '..X..', '..X..', '..X..']);
    const finder = ShortestPathFinder(SlidingMovement());

    final path = finder.find(grid, const Point(0, 0), const Point(4, 4));

    expect(path, isNull);
  });

  test('blocked start returns null', () {
    final grid = Grid(['XXX', 'XXX', 'XXX']);
    const finder = ShortestPathFinder(SlidingMovement());

    final path = finder.find(grid, const Point(0, 0), const Point(2, 2));

    expect(path, isNull);
  });

  test('field larger than 99 is rejected', () {
    final row = '.' * 100;
    expect(() => Grid(List.filled(100, row)), throwsArgumentError);
  });

  test('99x99 empty field solved through compute', () async {
    final row = '.' * 99;
    final result = await compute(solveLargeField, {
      'field': List.filled(99, row),
      'start': {'x': 0, 'y': 0},
      'end': {'x': 98, 'y': 98},
    });

    final steps = (result['steps'] as List).cast<Map<String, dynamic>>();
    expect(steps, hasLength(2));
    expect(steps.first, {'x': 0, 'y': 0});
    expect(steps.last, {'x': 98, 'y': 98});
  });

  test('findShortestPath returns SolvedModel with API-style steps', () {
    const taskJson = {
      'id': 'live-task',
      'field': ['.X.', '.X.', '...'],
      'start': {'x': 2, 'y': 1},
      'end': {'x': 0, 'y': 2},
    };
    final task = TaskModel.fromJson(taskJson);

    final solved = findShortestPath(task);

    expect(solved, isNotNull);
    expect(solved!.id, 'live-task');
    expect(solved.steps, hasLength(3));
    expect(solved.start, const PointModel(x: 2, y: 1));
    expect(solved.end, const PointModel(x: 0, y: 2));
    expect(
      jsonEncode(solved.steps.map((p) => p.toJson()).toList()),
      '[{"x":2,"y":1},{"x":1,"y":2},{"x":0,"y":2}]',
    );
  });

  test('findShortestPath lists every crossed cell, not only turn points', () {
    // Blocked centre forces a go-around; the API wants each cell listed.
    const taskJson = {
      'id': 'expand-task',
      'field': ['....', '.XX.', '.XX.', '....'],
      'start': {'x': 0, 'y': 0},
      'end': {'x': 3, 'y': 3},
    };
    final task = TaskModel.fromJson(taskJson);

    final solved = findShortestPath(task);

    expect(solved, isNotNull);
    // Consecutive steps must always be adjacent cells (a step of one cell).
    final steps = solved!.steps;
    expect(steps.first, const PointModel(x: 0, y: 0));
    expect(steps.last, const PointModel(x: 3, y: 3));
    for (var i = 1; i < steps.length; i++) {
      final dx = (steps[i].x - steps[i - 1].x).abs();
      final dy = (steps[i].y - steps[i - 1].y).abs();
      expect(dx <= 1 && dy <= 1 && (dx + dy) > 0, isTrue);
    }
    expect(steps, hasLength(7));
  });

  test('expandFullPath fills in the cells between turn points', () {
    final turns = <Point>[const Point(0, 3), const Point(3, 0)];

    expect(expandFullPath(turns), <Point>[
      const Point(0, 3),
      const Point(1, 2),
      const Point(2, 1),
      const Point(3, 0),
    ]);
  });

  test('expandFullPath keeps a single-cell path untouched', () {
    expect(expandFullPath(<Point>[const Point(1, 1)]), <Point>[
      const Point(1, 1),
    ]);
  });

  test('findShortestPath returns null for unsolvable task', () {
    const taskJson = {
      'id': 'unsolvable',
      'field': ['..X..', '..X..', '..X..', '..X..', '..X..'],
      'start': {'x': 0, 'y': 0},
      'end': {'x': 4, 'y': 4},
    };
    final task = TaskModel.fromJson(taskJson);

    expect(findShortestPath(task), isNull);
  });
}
