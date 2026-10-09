import 'package:flutter/material.dart';
import 'package:webspark_task/components/preview/widget/body/preview_body.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';

/// View of the Preview screen (п.1.4): a single solved field drawn as a
/// square grid of `(x,y)` cells plus its path label.
class PreviewView extends StatelessWidget {
  const PreviewView({super.key, required this.solved});

  final SolvedModel solved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.previewScreenTitle),
      body: PreviewBody(solved: solved),
    );
  }
}
