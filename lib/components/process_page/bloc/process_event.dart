part of 'process_bloc.dart';

@freezed
sealed class ProcessEvent with _$ProcessEvent {
  const factory ProcessEvent.started({List<TaskModel>? tasks}) =
      ProcessStarted;

  const factory ProcessEvent.submitted() = ProcessSubmitted;
}
