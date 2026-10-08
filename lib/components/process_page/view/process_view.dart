import 'package:flutter/material.dart';
import 'package:webspark_task/components/process_page/widget/body/process_body.dart';
import 'package:webspark_task/components/process_page/widget/process_preview_model.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';

class ProcessView extends StatelessWidget {
  const ProcessView({
    super.key,
    this.previewState = ProcessPreviewState.calculating,
  });

  final ProcessPreviewState previewState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.processScreenTitle),
      body: ProcessBody(previewState: previewState),
    );
  }
}

