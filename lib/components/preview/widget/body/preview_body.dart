import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/preview/widget/path_grid.dart';
import 'package:webspark_task/components/preview/widget/preview_mocks.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';
import 'package:webspark_task/shared/models/solved_model.dart';

/// Body of the Preview screen: the square field on top and the human
/// readable path right under it.
class PreviewBody extends StatelessWidget {
  const PreviewBody({super.key, required this.solved});

  final SolvedModel solved;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final steps = solved.steps;
    final pathLabel = steps.isEmpty
        ? l10n.emptyResultsMessage
        : steps.map((p) => '(${p.x},${p.y})').join(' -> ');

    return SafeArea(
      child: Padding(
        padding: AppInsets.homeBody,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PathGrid(
                key: const ValueKey('preview_grid'),
                size: solved.field.length,
                roleAt: (x, y) => PreviewMocks.roleOf(solved, x, y),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.emptyCell,
                border: Border.all(color: AppColors.lockedCell, width: 1.w),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.previewPathLengthLabel(steps.length),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.bodyFontSize.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    pathLabel,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.lockedCell,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
