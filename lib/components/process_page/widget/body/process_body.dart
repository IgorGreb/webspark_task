import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_task/components/process_page/bloc/process_bloc.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';
import 'package:webspark_task/shared/widget/app_loader.dart';
import 'package:webspark_task/shared/widget/try_again_widget.dart';

class ProcessBody extends StatelessWidget {
  const ProcessBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ProcessBloc, ProcessState>(
      buildWhen: (previous, current) =>
          previous.isFetching != current.isFetching ||
          previous.isCalculating != current.isCalculating ||
          previous.isSubmitting != current.isSubmitting ||
          previous.isReady != current.isReady ||
          previous.progress != current.progress ||
          previous.failure != current.failure,
      builder: (context, state) {
        final header = state.isReady
            ? l10n.calculationsFinished
            : l10n.calculationsInProgress;
  
        final isBusy = state.isFetching || state.isSubmitting;

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: AppInsets.homeBody,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      header,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: AppSizes.bodyFontSize.sp),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '${state.progress}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppSizes.inputFontSize.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.dividerColor,
                      ),
                    ),
                    Center(
                      child: AppLoader(
                        size: 100,
                        value: isBusy ? null : state.progress / 100,
                      ),
                    ),
                    if (state.failure != null) ...[
                      SizedBox(height: 12.h),
                      // Fetch failed (nothing solved yet) -> full retry
                      // re-dispatches ProcessStarted, like fwipp's TryAgainWidget.
                      // Submit failed (results kept, isReady) -> retry submit.
                      TryAgainWidget(
                        failure: state.failure,
                        onPressed: () => context.read<ProcessBloc>().add(
                          state.isReady
                              ? const ProcessEvent.submitted()
                              : const ProcessEvent.started(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
