import 'dart:math' show max, min;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'grid_cell.dart';

/// Square `size x size` field drawn with [LayoutBuilder].
///
/// Every child gets the very same box, so the cells stay square on any
/// screen and any `textScale`. [roleAt] decides the colour of a cell and is
/// the only hook a caller needs to describe its own field.
///
/// Large fields (up to 99x99) are wrapped in an [InteractiveViewer] so the
/// user can pinch-zoom and pan to inspect a single cell once the natural
/// cell size would drop below [_minCellSize].
class PathGrid extends StatelessWidget {
  const PathGrid({super.key, required this.size, required this.roleAt});

  final int size;
  final GridCellRole Function(int x, int y) roleAt;

  static const double _gap = 2;
  static const double _minCellSize = 24;

  /// Above this board size coordinates are hidden (see [GridCell.hideLabel]).
  static const int _labelThreshold = 20;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = min(constraints.maxWidth, constraints.maxHeight);
        if (size <= 0 || !side.isFinite || side <= 0) {
          return const SizedBox.shrink();
        }

        // Natural cell size if the whole field fits; grow it when it would
        // get too small to read, then let the viewer scroll/zoom it.
        final cell = max(_minCellSize.w, side / size);
        final gridSide = cell * size;
        final hideLabels = size > _labelThreshold;

        Widget grid = SizedBox.square(
          dimension: gridSide,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            // Large boards recycle off-screen cells instead of keeping all
            // ~10k widgets alive in one layout pass.
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true,
            addSemanticIndexes: false,
            cacheExtent: cell * 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size,
              mainAxisSpacing: _gap.w,
              crossAxisSpacing: _gap.w,
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
                hideLabel: hideLabels,
              );
            },
          ),
        );

        // Only wrap when the field overflows the viewport, otherwise a plain
        // centred grid keeps the common small cases free of gesture churn.
        if (gridSide > side) {
          grid = InteractiveViewer(
            key: const ValueKey('preview_viewer'),
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
