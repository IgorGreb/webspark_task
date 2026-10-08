import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/process_page/widget/process_preview_model.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/widget/app_loader.dart';
import 'package:webspark_task/shared/widget/error_banner.dart';

class ProcessBody extends StatelessWidget {
  const ProcessBody({super.key, required this.previewState});

  final ProcessPreviewState previewState;

  bool get _isFetching => previewState == ProcessPreviewState.fetching;

  bool get _isFinished {
    switch (previewState) {
      case ProcessPreviewState.fetching:
      case ProcessPreviewState.calculating:
        return false;
      case ProcessPreviewState.ready:
      case ProcessPreviewState.submitting:
      case ProcessPreviewState.submitError:
        return true;
    }
  }

  bool get _isSubmitting => previewState == ProcessPreviewState.submitting;

  bool get _showError => previewState == ProcessPreviewState.submitError;

  String _headerText(BuildContext context) {
    final l10n = context.l10n;
    if (_isFinished) return l10n.calculationsFinished;
    return l10n.calculationsInProgress;
  }

  String _percentText() {
    switch (previewState) {
      case ProcessPreviewState.fetching:
        return '0%';
      case ProcessPreviewState.calculating:
        return '38%';
      case ProcessPreviewState.ready:
      case ProcessPreviewState.submitting:
      case ProcessPreviewState.submitError:
        return '100%';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppInsets.homeBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _headerText(context),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: AppSizes.bodyFontSize.sp),
          ),
          SizedBox(height: 12.h),
          if (!_isFetching)
            Text(
              _percentText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.inputFontSize.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height: 12.h),
          if (!_isFinished || _isSubmitting)
            Center(
              child: _isSubmitting
                  ? Text(
                      context.l10n.sendingResults,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: AppSizes.inputFontSize.sp),
                    )
                  : const AppLoader(),
            ),
          if (!_isFetching) ...[
            SizedBox(height: 12.h),
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kProcessTasksMock.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final task = kProcessTasksMock[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: AppSizes.inputFontSize.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '${task.percent}%',
                        style: TextStyle(fontSize: AppSizes.inputFontSize.sp),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 1),
          ],
          if (_showError) ...[
            SizedBox(height: 12.h),
            const ErrorBanner(failure: SomeFailure.serverError),
          ],
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}


