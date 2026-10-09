part of 'preview_bloc.dart';

@freezed
sealed class PreviewEvent with _$PreviewEvent {
  /// Loads [solved] into the screen. Fired by the bloc provider with the
  /// model handed over by the Result list through the router `extra`.
  const factory PreviewEvent.started(SolvedModel solved) = PreviewStarted;
}
