import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'grid_cell.dart';

/// Square `size x size` field drawn with [LayoutBuilder].
///
/// Every child gets the very same box, so the cells stay square on any
/// screen and any `textScale`. [roleAt] decides the colour of a cell and is
/// the only hook a caller needs to describe its own field.
class PathGrid extends StatelessWidget {
  const PathGrid({super.key, required this.size, required this.roleAt});

  final int size;
  final GridCellRole Function(int x, int y) roleAt;

  static const double _gap = 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = min(constraints.maxWidth, constraints.maxHeight);
        if (size <= 0 || !side.isFinite || side <= 0) {
          return const SizedBox.shrink();
        }

        return Center(
          child: SizedBox.square(
            dimension: side,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
