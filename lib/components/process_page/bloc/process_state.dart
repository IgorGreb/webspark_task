part of 'process_bloc.dart';

/// Progress phases of the Process screen.
///
/// `solved/total*100` is the progress; sending starts only at 100%.
@freezed
abstract class ProcessState with _$ProcessState {
  const factory ProcessState({
    @Default(0) int total,
    @Default(0) int solved,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSubmitted,
    @Default(false) bool isFetching,
    @Default(false) bool isCalculating,
    SomeFailure? failure,
    @Default([]) List<SolvedModel> results,
  }) = _ProcessState;

  const ProcessState._();

  /// Overall progress in percent.
  int get progress => total == 0 ? 0 : (solved * 100 / total).round();

  bool get isReady => total > 0 && solved >= total;
}
