part of 'preview_bloc.dart';

@freezed
abstract class PreviewState with _$PreviewState {
  const factory PreviewState({
    SolvedModel? solved,
    // O(1) cell lookup: step keys `y * 256 + x` precomputed once, so a 99x99
    // grid (9801 cells) no longer does steps.any() per cell (~100M compares).
    @Default(<int>{}) Set<int> pathKeys,
    // Memoized label: building "(x,y)->..." for 10k steps per rebuild
    // allocates megabytes; cap it and compute once.
    @Default('') String label,
  }) = _PreviewState;

  const PreviewState._();

  int get size => solved?.field.length ?? 0;

  bool get hasNoModel => solved == null;

  bool get isEmpty => solved == null || solved!.steps.isEmpty;

  int get stepCount => solved?.steps.length ?? 0;

  static const int _labelThreshold = 400;

  String get pathLabel {
    final model = solved;
    if (model == null) return '';
    // Respect the precomputed (possibly truncated) label; compute lazily
    // only for states built directly (e.g. in unit tests).
    if (label.isNotEmpty || model.steps.isEmpty) return label;
    return buildPathLabel(model.steps);
  }

  /// Shared builder: truncates long paths instead of allocating a huge string.
  static String buildPathLabel(List<PointModel> steps) {
    if (steps.isEmpty) return '';
    final buffer = StringBuffer();
    var count = 0;
    for (var i = 0; i < steps.length; i++) {
      final chunk = '(${steps[i].x},${steps[i].y})';
      final extra = (i == 0 ? 0 : 2) + chunk.length;
      if (buffer.length + extra > _labelThreshold && i < steps.length - 1) {
        buffer.write('->… (+${steps.length - i} more)');
        break;
      }
      if (i > 0) buffer.write('->');
      buffer.write(chunk);
      count = i + 1;
    }
    // Ensure the last cell is always visible so the tail is not misleading.
    if (count < steps.length) {
      final tail = '(${steps.last.x},${steps.last.y})';
      if (!buffer.toString().endsWith(tail)) {
        buffer.write('->…->$tail');
      }
    }
    return buffer.toString();
  }

  /// Key encoding must match [_key] below.
  static int keyOf(int x, int y) => y * 256 + x;

  static Set<int> keysOf(SolvedModel? model) {
    if (model == null) return const <int>{};
    return <int>{for (final p in model.steps) p.y * 256 + p.x};
  }

  GridCellRole roleAt(int x, int y) {
    final model = solved;
    if (model == null) return GridCellRole.empty;
    if (x == model.start.x && y == model.start.y) return GridCellRole.start;
    if (x == model.end.x && y == model.end.y) return GridCellRole.end;
    // Fast path for bloc-built states (keys precomputed once); fallback to a
    // linear scan for states constructed directly (unit tests, copyWith).
    if (pathKeys.isNotEmpty) {
      if (pathKeys.contains(y * 256 + x)) return GridCellRole.path;
    } else if (model.steps.any((p) => p.x == x && p.y == y)) {
      return GridCellRole.path;
    }
    if (_isBlocked(model, x, y)) return GridCellRole.locked;
    return GridCellRole.empty;
  }

  static bool _isBlocked(SolvedModel model, int x, int y) =>
      y < model.field.length &&
      x < model.field[y].length &&
      model.field[y][x] == 'X';
}
