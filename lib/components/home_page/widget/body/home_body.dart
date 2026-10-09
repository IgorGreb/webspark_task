import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart';
import 'package:webspark_task/core/validators/url_validator.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/widget/try_again_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _focusNode = FocusNode();
  late final TextEditingController _controller;
  late final ValueNotifier<bool> _hasFocus = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<HomeBloc>().state.url,
    );
    // Scoped rebuild: only the hint needs focus state, not the whole body.
    _focusNode.addListener(() => _hasFocus.value = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _hasFocus.dispose();
    super.dispose();
  }

  InputBorder _underline(Color color) => UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: AppSizes.inputBorderWidth),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final underline = _underline(AppColors.lockedCell);
    final errorTextStyle = TextStyle(
      fontSize: 12.sp,
      color: Theme.of(context).colorScheme.error,
    );
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.url != current.url && current.url != _controller.text,
      listener: (context, state) {
        _controller.value = TextEditingValue(
          text: state.url,
          selection: TextSelection.collapsed(offset: state.url.length),
        );
      },
      child: SingleChildScrollView(
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
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _hasFocus,
                      builder: (context, hasFocus, _) => TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) => context.read<HomeBloc>().add(
                          HomeEvent.urlChanged(value),
                        ),
                        onSubmitted: (_) => context.read<HomeBloc>().add(
                          const HomeEvent.submitted(),
                        ),
                        decoration: InputDecoration(
                          hintText: hasFocus ? null : l10n.baseUrlHint,
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
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // While validating the URL against the server show an inline
            // spinner so the tap has visible feedback before navigation.
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                if (state.status != HomeStatus.submitting) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: const Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                  ),
                );
              },
            ),
            // Cleartext warning: http:// URLs ship results unencrypted.
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => previous.url != current.url,
              builder: (context, state) {
                if (!UrlValidator.isPlainHttp(state.url.trim())) {
                  return const SizedBox.shrink();
                }
                final theme = Theme.of(context);
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      l10n.insecureHttpWarning,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onErrorContainer,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.failure != current.failure ||
                  previous.status != current.status,
              builder: (context, state) {
                final failure = state.failure;
                if (failure == null) {
                  return const SizedBox.shrink();
                }
                // Field-format error (invalid URL) stays a compact one-liner
                // under the input, like before.
                if (state.status == HomeStatus.failure &&
                    state.tasks == null &&
                    failure == SomeFailure.invalidUrl) {
                  return SizedBox(
                    height: 20.h,
                    child: Text(
                      failure.message,
                      style: errorTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
                // Server/network failure after submit: full Try Again that
                // re-dispatches submit, staying on Home (no navigation).
                if (state.status == HomeStatus.failure) {
                  return TryAgainWidget(
                    failure: failure,
                    onPressed: () => context.read<HomeBloc>().add(
                      const HomeEvent.submitted(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
