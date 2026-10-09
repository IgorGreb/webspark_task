import 'dart:math' show max, min;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

import 'grid_cell.dart';

/// Square `size x size` field drawn with [LayoutBuilder].
///
/// Every child gets the very same box, so the cells stay square on any
/// screen and any `textScale`. [roleAt] decides the colour of a cell and is
/// the only hook a caller needs to describe its own field.
///
/// Boards up to [_labelThreshold] are drawn as real [GridCell] widgets so
/// the `(x,y)` captions stay accessible to tests and semantics.
///
/// Bigger boards are drawn by a single [GridCellPainter]: a widget-per-cell
/// grid cannot lazily recycle here — the grid viewport is exactly as big as
/// its content, so every cell is "visible" and a 99x99 board would build
/// ~10k widgets in one frame while keeping one compositing layer per cell
/// alive during pan/zoom. The painter merges all cells into a handful of
/// draw calls instead.
class PathGrid extends StatefulWidget {
  const PathGrid({super.key, required this.size, required this.roleAt});

  final int size;
  final GridCellRole Function(int x, int y) roleAt;

  static const double _gap = 2;
  static const double _minCellSize = 24;

  /// Above this board size coordinates are hidden (see [GridCell.hideLabel])
  /// and the board is painted by [GridCellPainter] instead of built as
  /// widgets.
  static const int _labelThreshold = 20;

  @override
  State<PathGrid> createState() => _PathGridState();
}

class _PathGridState extends State<PathGrid> {
  /// Pan/zoom matrix of the [InteractiveViewer].
  ///
  /// It also drives the visible window of [GridCellPainter]: every gesture
  /// tick notifies this controller, which rebuilds the painter with the new
  /// cull rect. An explicit listener is required because the board's
  /// [RepaintBoundary] layer is cached between paints — relying on the
  /// framework to re-invoke `paint()` after panning would leave cells blank.
  final TransformationController _viewerController =
      TransformationController();

  @override
  void dispose() {
    _viewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = min(constraints.maxWidth, constraints.maxHeight);
        if (widget.size <= 0 || !side.isFinite || side <= 0) {
          return const SizedBox.shrink();
        }
        final size = widget.size;
        final roleAt = widget.roleAt;

        // Natural cell size if the whole field fits; grow it when it would
        // get too small to read, then let the viewer scroll/zoom it.
        final cell = max(PathGrid._minCellSize.w, side / size);
        final gridSide = cell * size;
        final usePainter = size > PathGrid._labelThreshold;

        final Widget board;
        if (usePainter) {
          // The viewer anchors the oversized child top-left (OverflowBox)
          // and applies the gesture matrix about that origin, so the window
          // visible in the viewport maps back to board coordinates through
          // the inverse matrix.
          board = ListenableBuilder(
            listenable: _viewerController,
            builder: (context, _) {
              final visible = gridSide <= side
                  ? Offset.zero & Size.square(gridSide)
                  : MatrixUtils.inverseTransformRect(
                      _viewerController.value,
                      Offset.zero & Size.square(side),
                    );
              return CustomPaint(
                painter: GridCellPainter(
                  size: size,
                  cellSize: cell,
                  roleAt: roleAt,
                  visible: visible,
                ),
              );
            },
          );
        } else {
          board = GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            // The whole small board is isolated by the RepaintBoundary
            // below; per-cell boundaries would only add layer churn.
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            cacheExtent: cell * 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size,
              mainAxisSpacing: PathGrid._gap.w,
              crossAxisSpacing: PathGrid._gap.w,
            ),
            itemCount: size * size,
            itemBuilder: (context, index) {
              // The field is row major: the API stores a cell as field[y][x].
              final y = index ~/ size;
              final x = index % size;
              return GridCell(
                key: ValueKey('cell_${x}_$y'),
                x: x,
                y: y,
                role: roleAt(x, y),
              );
            },
          );
        }

        // Own layer for the board: between gesture ticks the cached layer is
        // reused, and on ticks the painter re-records only the visible cells.
        Widget grid = RepaintBoundary(
          child: SizedBox.square(dimension: gridSide, child: board),
        );

        // Only wrap when the field overflows the viewport, otherwise a plain
        // centred grid keeps the common small cases free of gesture churn.
        if (gridSide > side) {
          grid = InteractiveViewer(
            key: const ValueKey('preview_viewer'),
            transformationController: _viewerController,
            constrained: false,
            boundaryMargin: EdgeInsets.all(side),
            minScale: 1,
            maxScale: 5,
            child: grid,
          );
        } else {
          grid = Center(child: grid);
        }

        return grid;
      },
    );
  }
}

/// Paints a large board (see [PathGrid._labelThreshold]) without one widget
/// per cell: cells are merged into one path per [GridCellRole] plus a shared
/// border path, so a fully on-screen 99x99 board would cost ~6 draw calls.
///
/// Only cells intersecting [visible] are recorded — the window in board
/// coordinates that the [InteractiveViewer] viewport currently shows. The
/// window is pushed in by `PathGrid` on every controller tick (pan/zoom),
/// which makes the culling safe: repaints are driven by the transform, not
/// by the framework re-invoking `paint()` on the cached layer.
class GridCellPainter extends CustomPainter {
  GridCellPainter({
    required this.size,
    required this.cellSize,
    required this.roleAt,
    required this.visible,
  });

  /// Board width and height in cells.
  final int size;

  /// Distance between the top-left corners of neighbouring cells.
  final double cellSize;

  final GridCellRole Function(int x, int y) roleAt;

  /// Region of the board (board coordinates) that can currently appear on
  /// screen; cells outside it are skipped.
  final Rect visible;

  /// Keep in sync with [GridCell]'s decoration.
  static const double _borderWidth = 1;
  static const double _radius = 4;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    if (size <= 0 || cellSize <= 0) return;

    // One cell of margin guards against rounding at the window edges.
    final window = visible.inflate(cellSize);
    final x0 = max(0, (window.left / cellSize).floor());
    final y0 = max(0, (window.top / cellSize).floor());
    final x1 = min(size - 1, (window.right / cellSize).ceil());
    final y1 = min(size - 1, (window.bottom / cellSize).ceil());
    if (x0 > x1 || y0 > y1) return;

    final boxSide = max(1.0, cellSize - PathGrid._gap.w);
    final radius = Radius.circular(_radius.r);
    final paths = List<Path>.generate(
      GridCellRole.values.length,
      (_) => Path(),
    );
    final border = Path();

    for (var y = y0; y <= y1; y++) {
      final top = y * cellSize;
      for (var x = x0; x <= x1; x++) {
        final rrect = RRect.fromRectAndRadius(
          Rect.fromLTWH(x * cellSize, top, boxSide, boxSide),
          radius,
        );
        paths[roleAt(x, y).index].addRRect(rrect);
        border.addRRect(rrect);
      }
    }

    final fill = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < paths.length; i++) {
      if (paths[i].getBounds().isEmpty) continue;
      fill.color = GridCellRole.values[i].fill;
      canvas.drawPath(paths[i], fill);
    }
    if (!border.getBounds().isEmpty) {
      canvas.drawPath(
        border,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = max(1.0, _borderWidth.w)
          ..color = AppColors.lockedCell,
      );
    }
  }

  @override
  bool shouldRepaint(GridCellPainter old) =>
      old.size != size ||
      old.cellSize != cellSize ||
      old.roleAt != roleAt ||
      old.visible != visible;
}
