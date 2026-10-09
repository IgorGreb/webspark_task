part of 'preview_bloc.dart';

@freezed
abstract class PreviewState with _$PreviewState {
  const factory PreviewState({SolvedModel? solved}) = _PreviewState;

  const PreviewState._();

  /// Side of the square field; `0` while no model is loaded yet.
  int get size => solved?.field.length ?? 0;

  /// `true` when there is nothing to draw (no model or an empty path).
  bool get isEmpty => solved == null || solved!.steps.isEmpty;

  /// Number of steps in the solved path.
  int get stepCount => solved?.steps.length ?? 0;

  /// Human readable path with spaces around the arrows: `(0,0) -> (1,1)`.
  String get pathLabel => solved == null
      ? ''
      : solved!.steps.map((p) => '(${p.x},${p.y})').join(' -> ');

  /// Maps a cell of the field onto its visual role so the grid can pick the
  /// matching colour from [GridCellRole].
  GridCellRole roleAt(int x, int y) {
    final model = solved;
    if (model == null) return GridCellRole.empty;
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
