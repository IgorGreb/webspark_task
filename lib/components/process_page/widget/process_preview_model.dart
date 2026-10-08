import 'package:flutter/material.dart';

/// UI-only preview state for the Process screen (mocks, no bloc).
///
/// The screen shows processing only: no finished text, no results,
/// no send button. Real states arrive with `process-logic`.
enum ProcessPreviewState {
  /// Fetching tasks: progress text + loader, list not yet visible.
  fetching,

  /// Calculating: progress text, percent, loader, list of mocks.
  calculating,
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

