part of 'home_bloc.dart';

enum HomeStatus { initial, submitting, success, failure }

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default('') String url,
    @Default(false) bool isValid,
    SomeFailure? failure,
    @Default(HomeStatus.initial) HomeStatus status,
    @Default(null) List<TaskModel>? tasks,
  }) = _HomeState;
}
