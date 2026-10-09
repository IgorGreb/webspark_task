import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

/// Role a cell plays inside the solved path. Drives both the fill and the
/// label colour so the grid stays readable on any field.
enum GridCellRole {
  /// Free cell that the path does not use.
  empty,

  /// Cell holding `X`, unreachable for the queen.
  locked,

  /// Intermediate stop of the shortest path.
  path,

  /// Where the queen starts.
  start,

  /// Where the queen has to arrive.
  end,
}

/// One square cell of the preview grid with its `(x,y)` coordinates inside.
///
/// The cell is painted with the matching [AppColors] entry and keeps a 1:1
/// aspect ratio because the parent grid sizes every child equally.
class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.x,
    required this.y,
    this.role = GridCellRole.empty,
  });

  final int x;
  final int y;
  final GridCellRole role;

  static const double _labelFontSize = 10;
  static const double _borderWidth = 1;
  static const double _radius = 4;

  Color get _background => switch (role) {
    GridCellRole.empty => AppColors.emptyCell,
    GridCellRole.locked => AppColors.lockedCell,
    GridCellRole.path => AppColors.pathCell,
    GridCellRole.start => AppColors.startingCell,
    GridCellRole.end => AppColors.terminalCell,
  };

  Color get _labelColor => switch (role) {
    GridCellRole.empty => AppColors.lockedCell,
    GridCellRole.locked ||
    GridCellRole.path ||
    GridCellRole.start ||
    GridCellRole.end => AppColors.buttonTextColor,
  };

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _background,
        border: Border.all(color: AppColors.lockedCell, width: _borderWidth.w),
        borderRadius: BorderRadius.circular(_radius.r),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              '($x,$y)',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _labelColor,
                fontSize: _labelFontSize.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
