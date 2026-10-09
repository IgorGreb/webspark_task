import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';

class FailureTextWidget extends StatelessWidget {
  const FailureTextWidget({
    super.key,
    this.failure,
    this.failureText,
    this.textStyle,
    this.textAlign,
    this.maxLines,
  });

  final SomeFailure? failure;
  final String? failureText;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final text =
        failureText ??
        failure?.localizedMessage(context) ??
        context.maybeL10n?.emptyResultsMessage ??
        'Something went wrong';
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      style:
          textStyle ??
          TextStyle(
            fontSize: 13.sp,
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
