import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/widget/failure_text_widget.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({
    required this.onPressed,
    super.key,
    this.failure,
    this.failureText,
  });

  final SomeFailure? failure;
  final String? failureText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FailureTextWidget(failure: failure, failureText: failureText),
            SizedBox(height: 12.h),
            TextButton.icon(
              key: const ValueKey('try_again_button'),
              icon: Icon(Icons.refresh, size: 18.sp),
              label: Text(context.l10n.tryAgain),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
