import 'package:flutter/material.dart';
import 'package:webspark_task/components/process_page/view/process_view.dart';
import 'package:webspark_task/components/process_page/widget/process_preview_model.dart';

class ProcessBlocProvider extends StatelessWidget {
  const ProcessBlocProvider({
    super.key,
    this.previewState = ProcessPreviewState.ready,
  });

  /// UI-only switch for previewing mock states (no bloc yet).
  final ProcessPreviewState previewState;

  @override
  Widget build(BuildContext context) => ProcessView(previewState: previewState);
}
