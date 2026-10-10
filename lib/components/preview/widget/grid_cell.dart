import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

/// Role a cell plays inside the solved path. Drives both the fill and the
/// label colour so the grid stays readable on any field.
enum GridCellRole {
  /// Free cell that the path does not use.
  empty,

  /// Cell holding `X`, unreachable for the path.
  locked,

  /// Intermediate stop of the shortest path.
  path,

  /// Where the path starts.
  start,

  /// Where the path has to arrive.
  end,
}

/// Role colors shared by the widget cell ([GridCell]) and the large-board
/// painter (`GridCellPainter` in `path_grid.dart`).
extension GridCellRoleStyle on GridCellRole {
  /// Fill color of the cell.
  Color get fill => switch (this) {
    GridCellRole.empty => AppColors.emptyCell,
    GridCellRole.locked => AppColors.lockedCell,
    GridCellRole.path => AppColors.pathCell,
    GridCellRole.start => AppColors.startingCell,
    GridCellRole.end => AppColors.terminalCell,
  };

  /// Coordinate caption color.
  Color get labelColor => switch (this) {
    GridCellRole.empty => AppColors.lockedCell,
    GridCellRole.locked ||
    GridCellRole.path ||
    GridCellRole.start ||
    GridCellRole.end => AppColors.buttonTextColor,
  };
}

/// One square cell of the preview grid with its `(x,y)` coordinates inside.
///
/// Small fields show the `(x,y)` caption; large ones skip the text entirely
/// because they are drawn by `GridCellPainter` (see `path_grid.dart`).
class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.x,
    required this.y,
    this.role = GridCellRole.empty,
    this.hideLabel = false,
  });

  final int x;
  final int y;
  final GridCellRole role;
  final bool hideLabel;

  static const double _labelFontSize = 10;
  static const double _borderWidth = 1;
  static const double _radius = 4;

  @override
  Widget build(BuildContext context) {
    // Fast path for big boards: plain color + border radius via DecoratedBox,
    // but no per-cell text layout at all.
    if (hideLabel) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: role.fill,
          border: Border.all(
            color: AppColors.lockedCell,
            width: _borderWidth.w,
          ),
          borderRadius: BorderRadius.circular(_radius.r),
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: role.fill,
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
                color: role.labelColor,
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
