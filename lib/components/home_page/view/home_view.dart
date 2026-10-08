import 'package:flutter/material.dart';
import 'package:webspark_task/components/home_page/widget/body/home_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';
import 'package:webspark_task/shared/widget/start_contining_btn.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.homeScreenTitle),
      body: const HomeBody(),
      bottomNavigationBar: SafeArea(
        minimum: AppInsets.bottomBarSafeArea,
        child: MainBtn(
          onPressed: () {},
          label: context.l10n.startCountingProcess,
        ),
      ),
    );
  }
}
