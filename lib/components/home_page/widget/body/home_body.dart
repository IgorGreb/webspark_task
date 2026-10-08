import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart';
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
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<HomeBloc>().state.url,
    );
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
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
    final errorTextStyle = TextStyle(
      fontSize: 12.sp,
      color: Theme.of(context).colorScheme.error,
    );
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.url != current.url &&
          current.url != _controller.text,
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
                    child: TextField(
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
            SizedBox(
              height: 20.h,
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.failure != current.failure,
                builder: (context, state) {
                  final errorMessage = state.failure?.message;
                  if (errorMessage == null) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    errorMessage,
                    style: errorTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

