import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart';
import 'package:webspark_task/components/preview/widget/body/preview_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';

/// View of the Preview screen (п.1.4): a single solved field drawn as a
/// square grid of `(x,y)` cells plus its path label.
///
/// The model reaches the bloc through [PreviewEvent.started], so the view
/// only rebuilds the body when the state changes.
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
