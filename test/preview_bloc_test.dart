import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/widget/grid_cell.dart';
import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

const _field = <String>['...', '.X.', '...'];

final _solved = SolvedModel(
  id: 'bloc-test',
  field: _field,
  start: const PointModel(x: 0, y: 0),
  end: const PointModel(x: 2, y: 2),
  steps: const <PointModel>[
    PointModel(x: 0, y: 0),
    PointModel(x: 1, y: 0),
    PointModel(x: 2, y: 2),
  ],
);

final _noPath = SolvedModel(
  id: 'empty',
  field: _field,
  start: const PointModel(x: 0, y: 0),
  end: const PointModel(x: 2, y: 2),
  steps: const <PointModel>[],
);

void main() {
  group('PreviewState', () {
    test('empty state exposes zeroed view data', () {
      const state = PreviewState();

      expect(state.size, 0);
      expect(state.stepCount, 0);
      expect(state.isEmpty, isTrue);
      expect(state.pathLabel, '');
      expect(state.roleAt(0, 0), GridCellRole.empty);
    });

    test('size follows the field side', () {
      final state = PreviewState(solved: _solved);

      expect(state.size, 3);
    });

    test('path label joins steps with spaced arrows', () {
      final state = PreviewState(solved: _solved);

      expect(state.pathLabel, '(0,0) -> (1,0) -> (2,2)');
    });

    test('isEmpty is false when a path exists', () {
      final state = PreviewState(solved: _solved);

      expect(state.stepCount, 3);
      expect(state.isEmpty, isFalse);
    });

    test('isEmpty is true for an empty path', () {
      final state = PreviewState(solved: _noPath);

      expect(state.isEmpty, isTrue);
    });

    test('roleAt maps start, end, path and blocked cells', () {
      final state = PreviewState(solved: _solved);

      expect(state.roleAt(0, 0), GridCellRole.start);
      expect(state.roleAt(2, 2), GridCellRole.end);
      expect(state.roleAt(1, 0), GridCellRole.path);
      expect(state.roleAt(1, 1), GridCellRole.locked);
      expect(state.roleAt(0, 2), GridCellRole.empty);
    });
  });

  group('PreviewBloc', () {
    test('PreviewStarted loads the solved model into state', () async {
      final bloc = PreviewBloc();

      expect(bloc.state.solved, isNull);
      expect(bloc.state.size, 0);

      bloc.add(PreviewEvent.started(_solved));
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state.solved, _solved);
      expect(bloc.state.size, 3);

      await bloc.close();
    });
  });
}
