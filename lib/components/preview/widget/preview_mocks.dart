import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

/// Fallback sample for the Preview screen when the router receives no
/// `extra` (deep link, test, error recovery). Colour mapping now lives in
/// [PreviewState.roleAt].
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

  /// Solved task the screen renders when no model is passed in.
  static const SolvedModel solved = SolvedModel(
    id: 'preview-mock',
    field: field,
    start: start,
    end: end,
    steps: steps,
  );
}
