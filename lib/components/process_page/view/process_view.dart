import 'package:flutter/material.dart';
import 'package:webspark_task/components/process_page/widget/body/process_body.dart';
import 'package:webspark_task/components/process_page/widget/process_preview_model.dart';
import 'package:webspark_task/l10n/l10n.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/widget/custom_app_bar.dart';
import 'package:webspark_task/shared/widget/start_contining_btn.dart';

class ProcessView extends StatelessWidget {
  const ProcessView({
    super.key,
    this.previewState = ProcessPreviewState.calculating,
    this.isSendEnabled = true,
  });

  final ProcessPreviewState previewState;
  final bool isSendEnabled;

  bool get _isSubmitting => previewState == ProcessPreviewState.submitting;

  bool get _showSendButton {
    // Visible only after calculations finish (mock of the real rule).
    switch (previewState) {
      case ProcessPreviewState.fetching:
      case ProcessPreviewState.calculating:
        return false;
      case ProcessPreviewState.ready:
      case ProcessPreviewState.submitting:
      case ProcessPreviewState.submitError:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: CustomAppBar(title: l10n.processScreenTitle),
      body: ProcessBody(previewState: previewState),
      bottomNavigationBar: SafeArea(
        minimum: AppInsets.bottomBarSafeArea,
        child: _showSendButton
            ? (_isSubmitting
                  ? MainBtn(onPressed: null, label: l10n.sendResultsToServer)
                  : MainBtn(
                      onPressed: isSendEnabled ? () {} : null,
                      label: l10n.sendResultsToServer,
                    ))
            : const SizedBox.shrink(),
      ),
    );
  }
}


