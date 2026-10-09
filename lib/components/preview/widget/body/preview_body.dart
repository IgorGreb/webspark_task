import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/widget/path_grid.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

/// Body of the Preview screen: the square field on top and the human
/// readable path right under it. Pure renderer of [PreviewState].
class PreviewBody extends StatelessWidget {
  const PreviewBody({super.key, required this.state});

  final PreviewState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      child: Padding(
        padding: AppInsets.homeBody,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PathGrid(
                key: const ValueKey('preview_grid'),
                size: state.size,
                roleAt: state.roleAt,
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
                    l10n.previewPathLengthLabel(state.stepCount),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.bodyFontSize.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.isEmpty ? l10n.emptyResultsMessage : state.pathLabel,
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
