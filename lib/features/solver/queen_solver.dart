import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';

class Point {
  const Point(this.x, this.y);

  final int x;
  final int y;

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => '($x,$y)';
}

class Grid {
  Grid(List<String> rows) : _rows = List<String>.unmodifiable(rows) {
    final n = _rows.length;
    if (n < 2 || n > 99) {
      throw ArgumentError.value(n, 'n', 'Field size must satisfy 1 < n < 100');
    }
    for (final row in _rows) {
      if (row.length != n) {
        throw ArgumentError(
          'Field must be square: row length ${row.length} for size $n',
        );
      }
    }
  }

  final List<String> _rows;

  int get size => _rows.length;

  bool isInside(Point point) =>
      point.x >= 0 && point.x < size && point.y >= 0 && point.y < size;

  bool isFree(Point point) => isInside(point) && _rows[point.y][point.x] != 'X';
}

abstract class QueenStrategy {
  const QueenStrategy();

  Iterable<Point> nextPoints(Grid grid, Point from);
}

class QueenSlideStrategy implements QueenStrategy {
  const QueenSlideStrategy();

  static const List<(int, int)> _directions = <(int, int)>[
    (-1, -1),
    (0, -1),
    (1, -1),
    (-1, 0),
    (1, 0),
    (-1, 1),
    (0, 1),
    (1, 1),
  ];

  @override
  Iterable<Point> nextPoints(Grid grid, Point from) sync* {
    for (final (dx, dy) in _directions) {
      var x = from.x + dx;
      var y = from.y + dy;
      while (grid.isFree(Point(x, y))) {
        yield Point(x, y);
        x += dx;
        y += dy;
      }
    }
  }
}

class BfsSolver {
  const BfsSolver(this.strategy);

  final QueenStrategy strategy;

  List<Point>? solve(Grid grid, Point start, Point end) {
    if (!grid.isFree(start) || !grid.isFree(end)) return null;
    if (start == end) return <Point>[start];

    final visited = <Point>{start};
    final parent = <Point, Point>{};
    var frontier = <Point>[start];

    while (frontier.isNotEmpty) {
      final next = <Point>[];
      for (final from in frontier) {
        for (final to in strategy.nextPoints(grid, from)) {
          if (!visited.add(to)) continue;
          parent[to] = from;
          if (to == end) return _reconstruct(parent, start, end);
          next.add(to);
        }
      }
      frontier = next;
    }
    return null;
  }

  List<Point> _reconstruct(Map<Point, Point> parent, Point start, Point end) {
    final path = <Point>[end];
    var current = end;
    while (current != start) {
      current = parent[current]!;
      path.add(current);
    }
    return path.reversed.toList();
  }
}

List<Point> expandFullPath(List<Point> turns) {
  if (turns.length <= 1) return turns;

  final full = <Point>[turns.first];
  for (var i = 1; i < turns.length; i++) {
    final from = turns[i - 1];
    final to = turns[i];
    final dx = (to.x - from.x).sign;
    final dy = (to.y - from.y).sign;
    var x = from.x;
    var y = from.y;
    while (x != to.x || y != to.y) {
      x += dx;
      y += dy;
      full.add(Point(x, y));
    }
  }
  return full;
}

SolvedModel? solveTask(TaskModel task) {
  final grid = Grid(task.field);
  const solver = BfsSolver(QueenSlideStrategy());
  final path = solver.solve(
    grid,
    Point(task.start.x, task.start.y),
    Point(task.end.x, task.end.y),
  );
  if (path == null) return null;
  return SolvedModel(
    id: task.id,
    field: task.field,
    start: task.start,
    end: task.end,
    steps: expandFullPath(path).map((p) => PointModel(x: p.x, y: p.y)).toList(),
  );
}
