import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _focusNode = FocusNode();

  /// PR-1 pure-UI mock: no bloc, no validation.
  /// Non-null value here previews the error slot (PR-2 will drive it).
  static const String? _mockErrorMessage = null;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  InputBorder _underline(Color color) => UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: AppSizes.inputBorderWidth),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final underline = _underline(AppColors.lockedCell);
    final mockErrorMessage = _mockErrorMessage;
    final errorTextStyle = TextStyle(
      fontSize: 12.sp,
      color: Theme.of(context).colorScheme.error,
    );
    return SingleChildScrollView(
      padding: AppInsets.homeBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.setValidBaseUrl,
            style: TextStyle(fontSize: AppSizes.bodyFontSize.sp),
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.swap_horiz,
                size: AppSizes.inputFontSize.sp,
                color: AppColors.lockedCell,
              ),
              SizedBox(width: AppSizes.inputIconGap.w),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: AppSizes.inputHeight.h,
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: _focusNode.hasFocus ? null : l10n.baseUrlHint,
                      contentPadding: AppInsets.inputContent,
                      border: underline,
                      enabledBorder: underline,
                      focusedBorder: underline,
                      errorBorder: underline,
                      focusedErrorBorder: underline,
                      disabledBorder: underline,
                    ),
                    style: TextStyle(fontSize: AppSizes.inputFontSize.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Reserved error slot: keeps layout stable when PR-2 shows a message.
          SizedBox(
            height: 20.h,
            child: mockErrorMessage == null
                ? const SizedBox.shrink()
                : Text(
                    mockErrorMessage,
                    style: errorTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}
