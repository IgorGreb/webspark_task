import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/navigation/app_router.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';
import 'package:webspark_task/shared/widget/start_contining_btn.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: CustomAppBar(title: l10n.notFoundTitle),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.notFoundMessage),
              MainBtn(
                label: l10n.notFoundGoHome,
                onPressed: () => context.goNamed(KRoute.home.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
