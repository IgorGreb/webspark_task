import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/components/process_page/bloc/process_bloc.dart';
import 'package:webspark_task/components/process_page/widget/body/process_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';
import 'package:webspark_task/shared/widget/start_contining_btn.dart';

class ProcessView extends StatelessWidget {
  const ProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<ProcessBloc, ProcessState>(
      listenWhen: (previous, current) =>
          !previous.isSubmitted && current.isSubmitted,
      listener: (context, state) {
        if (context.mounted) context.goNamed(KRoute.results.name);
      },
      child: Scaffold(
        appBar: CustomAppBar(title: l10n.processScreenTitle),
        body: const ProcessBody(),
        bottomNavigationBar: SafeArea(
          minimum: AppInsets.bottomBarSafeArea,
          child: BlocBuilder<ProcessBloc, ProcessState>(
            buildWhen: (previous, current) =>
                previous.isReady != current.isReady ||
                previous.isSubmitting != current.isSubmitting,
            builder: (context, state) {
              if (!state.isReady) return const SizedBox.shrink();
              return MainBtn(
                onPressed: state.isSubmitting
                    ? null
                    : () => context.read<ProcessBloc>().add(
                        const ProcessEvent.submitted(),
                      ),
                label: l10n.sendResultsToServer,
              );
            },
          ),
        ),
      ),
    );
  }
}
