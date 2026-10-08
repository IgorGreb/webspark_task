import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.failure});

  final SomeFailure failure;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        failure.message,
        style: TextStyle(
          color: theme.colorScheme.onErrorContainer,
          fontSize: 13.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
