part of 'preview_bloc.dart';

@freezed
sealed class PreviewEvent with _$PreviewEvent {
  const factory PreviewEvent.started(SolvedModel solved) = PreviewStarted;
}
