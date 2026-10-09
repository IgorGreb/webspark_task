import 'package:webspark_task/components/preview/widget/grid_cell.dart';
import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

/// Static 4x4 sample used by the pure Preview UI so every state is visible
/// without a network call. Dropped as soon as real data flows in.
abstract final class PreviewMocks {
  /// Field rows, `.` is free and `X` is blocked. Coordinates are `field[y][x]`.
  static const List<String> field = <String>['....', '.X..', '..X.', '....'];

  static const PointModel start = PointModel(x: 0, y: 0);
  static const PointModel end = PointModel(x: 3, y: 3);

  static const List<PointModel> steps = <PointModel>[
    PointModel(x: 0, y: 0),
    PointModel(x: 1, y: 1),
    PointModel(x: 2, y: 2),
    PointModel(x: 3, y: 3),
  ];

  /// UI format of the path, spaces around the arrows: `(0,0) -> (1,1)`.
  static String get pathLabel => steps.map((p) => '(${p.x},${p.y})').join(' -> ');

  /// Solved task the screen renders while no real result is passed in.
  static const SolvedModel solved = SolvedModel(
    id: 'preview-mock',
    field: field,
    start: start,
    end: end,
    steps: steps,
  );

  /// Empty state: a field with nothing to show.
  static const SolvedModel empty = SolvedModel(
    id: 'preview-empty',
    field: field,
    start: start,
    end: end,
    steps: <PointModel>[],
  );

  /// Maps a cell of [model] onto its visual role.
  static GridCellRole roleOf(SolvedModel model, int x, int y) {
    if (x == model.start.x && y == model.start.y) return GridCellRole.start;
    if (x == model.end.x && y == model.end.y) return GridCellRole.end;
    if (model.steps.any((p) => p.x == x && p.y == y)) return GridCellRole.path;
    if (_isBlocked(model, x, y)) return GridCellRole.locked;
    return GridCellRole.empty;
  }

  static bool _isBlocked(SolvedModel model, int x, int y) =>
      y < model.field.length &&
      x < model.field[y].length &&
      model.field[y][x] == 'X';
}
