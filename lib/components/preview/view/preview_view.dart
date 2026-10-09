import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/widget/body/preview_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.previewScreenTitle),
      body: BlocBuilder<PreviewBloc, PreviewState>(
        builder: (context, state) => PreviewBody(state: state),
      ),
    );
  }
}
