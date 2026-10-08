/// UI-only preview state for the Process screen (mocks, no bloc).
///
/// The screen shows processing progress and the send action only:
/// no task list and no result paths are displayed here. Real states
/// arrive with `process-logic`.
enum ProcessPreviewState {
  /// Fetching tasks: progress text + loader.
  fetching,

  /// Calculating: progress text, percent, loader.
  calculating,

  /// Calculations finished: 100%, send button visible.
  ready,

  /// Sending results: button blocked with loader.
  submitting,

  /// Send failed: error message visible, button enabled again.
  submitError,
}
