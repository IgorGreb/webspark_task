part of 'preview_bloc.dart';

@freezed
abstract class PreviewState with _$PreviewState {
  const factory PreviewState({SolvedModel? solved}) = _PreviewState;

  const PreviewState._();

  int get size => solved?.field.length ?? 0;

  bool get hasNoModel => solved == null;

  bool get isEmpty => solved == null || solved!.steps.isEmpty;

  int get stepCount => solved?.steps.length ?? 0;

  String get pathLabel => solved == null
      ? ''
      : solved!.steps.map((p) => '(${p.x},${p.y})').join('->');

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
