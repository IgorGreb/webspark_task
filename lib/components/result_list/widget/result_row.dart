import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({super.key, required this.solved});

  final SolvedModel solved;

  @override
  Widget build(BuildContext context) {
    final pathStr = solved.steps.map((p) => '(${p.x},${p.y})').join('->');

    return InkWell(
      onTap: () => context.pushNamed(KRoute.preview.name, extra: solved),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
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
          const Divider(height: 1, thickness: 1, color: AppColors.dividerColor),
        ],
      ),
    );
  }
}
