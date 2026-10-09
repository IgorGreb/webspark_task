import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/widget/path_grid.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

class PreviewBody extends StatelessWidget {
  const PreviewBody({super.key, required this.state});

  final PreviewState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (state.hasNoModel) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            l10n.previewEmptyMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.bodyFontSize.sp,
              color: AppColors.lockedCell,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PathGrid(
                key: const ValueKey('preview_grid'),
                size: state.size,
                roleAt: state.roleAt,
              ),
            ),
            SizedBox(height: 12.h),
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
    );
  }
}
