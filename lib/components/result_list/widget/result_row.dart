import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/shared/constants/constants.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({super.key, required this.pathStr});

  final String pathStr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO(results-logic): navigate to preview with model
      },
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
          const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }
}
