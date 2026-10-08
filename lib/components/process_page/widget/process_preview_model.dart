import 'package:flutter/material.dart';

/// UI-only preview state for the Process screen (PR-4, mocks, no bloc).
///
/// Real states arrive with `process-logic`.
enum ProcessPreviewState {
  /// Fetching / calculating: progress text, percent, loader, list of mocks.
  calculating,

  /// All done: finished text, 100%, list complete, send button enabled.
  ready,

  /// POST in flight: button shows loader and is disabled.
  submitting,

  /// POST failed: error banner visible, button enabled again.
  submitError,
}

/// Mock item of the tasks list: title + percent.
@immutable
class ProcessTaskMock {
  const ProcessTaskMock({required this.title, required this.percent});

  final String title;
  final int percent;
}

const List<ProcessTaskMock> kProcessTasksMock = [
  ProcessTaskMock(title: 'Task 1', percent: 100),
  ProcessTaskMock(title: 'Task 2', percent: 64),
  ProcessTaskMock(title: 'Task 3', percent: 12),
];
