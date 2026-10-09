import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({super.key, required this.solved});

  final SolvedModel solved;

  @override
  Widget build(BuildContext context) {
    // Cheap memoized preview text: no per-build join of a 10k-step path.
    final pathStr = PreviewState.buildPathLabel(solved.steps);

    return InkWell(
      onTap: () => context.pushNamed(KRoute.preview.name, extra: solved),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Text(
          pathStr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.bodyFontSize.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
