part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.urlChanged(String url) = HomeUrlChanged;

  const factory HomeEvent.submitted() = HomeSubmitted;
}
