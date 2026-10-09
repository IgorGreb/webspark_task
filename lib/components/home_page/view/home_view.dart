import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart';
import 'package:webspark_task/components/home_page/widget/body/home_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';
import 'package:webspark_task/shared/widget/start_contining_btn.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == HomeStatus.success) {
          context.goNamed(KRoute.process.name, extra: state.tasks);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: context.l10n.homeScreenTitle),
        body: const HomeBody(),
        bottomNavigationBar: SafeArea(
          minimum: AppInsets.bottomBarSafeArea,
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              final isSubmitting = state.status == HomeStatus.submitting;
              // Always tappable (except while submitting): tapping with an
              // empty/invalid URL shows the inline error instead of a dead
              // grey button with no feedback.
              return MainBtn(
                onPressed: isSubmitting
                    ? null
                    : () => context.read<HomeBloc>().add(
                        const HomeEvent.submitted(),
                      ),
                label: context.l10n.startCountingProcess,
              );
            },
          ),
        ),
      ),
    );
  }
}
