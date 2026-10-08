import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark_task/features/solver/queen_solver.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/models/solved_model.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';
import 'package:webspark_task/shared/repositories/i_url_repository.dart';

part 'process_event.dart';
part 'process_state.dart';
part 'process_bloc.freezed.dart';

@injectable
class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  ProcessBloc(this._urlRepository, this._pathRepository)
    : super(const ProcessState()) {
    on<ProcessStarted>(_onStarted);
    on<ProcessSubmitted>(_onSubmitted);
  }

  final IUrlRepository _urlRepository;
  final IPathRepository _pathRepository;

  Future<void> _onStarted(
    ProcessStarted event,
    Emitter<ProcessState> emit,
  ) async {
    emit(const ProcessState(isFetching: true));

    final savedUrl = _urlRepository.getUrl().fold((_) => null, (url) => url);
    if (savedUrl == null || savedUrl.isEmpty) {
      emit(const ProcessState(failure: SomeFailure.invalidUrl));
      return;
    }

    final tasksResult = await _pathRepository.fetchTasks(savedUrl);

    final tasks = tasksResult.fold((_) => null, (tasks) => tasks);
    if (tasks == null) {
      emit(ProcessState(failure: _failureOf(tasksResult)));
      return;
    }

    emit(ProcessState(total: tasks.length, isCalculating: true));

    final results = <SolvedModel>[];
    var solved = 0;
    for (final task in tasks) {
      final solvedTask = await compute(_solveTaskIsolate, task);
      if (solvedTask != null) results.add(solvedTask);
      solved += 1;
      emit(
        ProcessState(
          total: tasks.length,
          solved: solved,
          isCalculating: true,
          results: List.unmodifiable(results),
        ),
      );
    }

    emit(
      ProcessState(
        total: tasks.length,
        solved: tasks.length,
        isCalculating: false,
        results: List.unmodifiable(results),
      ),
    );
  }

  Future<void> _onSubmitted(
    ProcessSubmitted event,
    Emitter<ProcessState> emit,
  ) async {
    if (!state.isReady || state.isSubmitting) return;

    final savedUrl = _urlRepository.getUrl().fold((_) => null, (url) => url);
    if (savedUrl == null || savedUrl.isEmpty) {
      emit(state.copyWith(failure: SomeFailure.invalidUrl));
      return;
    }

    emit(state.copyWith(isSubmitting: true, failure: null));

    final requests = state.results
        .map(
          (solved) => SubmitRequestModel(
            id: solved.id,
            result: SubmitResultModel.fromPoints(solved.steps),
          ),
        )
        .toList();

    final result = await _pathRepository.submitResults(savedUrl, requests);

    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, failure: failure)),
      (_) => emit(state.copyWith(isSubmitting: false, isSubmitted: true)),
    );
  }

  SomeFailure _failureOf(Either<SomeFailure, dynamic> result) =>
      result.fold((failure) => failure, (_) => SomeFailure.unknown);
}

SolvedModel? _solveTaskIsolate(TaskModel task) {
  try {
    return solveTask(task);
  } on ArgumentError {
    return null;
  }
}
