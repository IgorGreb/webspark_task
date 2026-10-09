import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:webspark_task/core/validators/url_validator.dart';
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
    if (state.isFetching || state.isCalculating) return;
    emit(const ProcessState(isFetching: true));

    final preloaded = event.tasks;
    List<TaskModel>? tasks = preloaded;
    if (tasks == null) {
      final savedUrl = _urlRepository.getUrl().fold((_) => null, (url) => url);
      if (savedUrl == null ||
          savedUrl.isEmpty ||
          !UrlValidator.isValid(savedUrl)) {
        if (!emit.isDone) {
          emit(const ProcessState(failure: SomeFailure.invalidUrl));
        }
        return;
      }

      final tasksResult = await _pathRepository.fetchTasks(savedUrl);
      if (emit.isDone) return;

      tasks = tasksResult.fold((_) => null, (tasks) => tasks);
      if (tasks == null) {
        if (!emit.isDone) {
          emit(ProcessState(failure: _failureOf(tasksResult)));
        }
        return;
      }
    }

    if (emit.isDone) return;
    emit(ProcessState(total: tasks.length, isCalculating: true));

    final results = <SolvedModel>[];
    var solved = 0;
    // Throttle progress emits: rebuilding the progress UI per task is wasteful
    // when hundreds of small fields solve in milliseconds.
    var lastEmit = DateTime.fromMillisecondsSinceEpoch(0);
    var lastProgress = 0;
    const throttle = Duration(milliseconds: 120);
    // One isolate spawn per chunk instead of per task: spawning an isolate
    // for every tiny 2x2 field costs ~100x the solve itself and floods the
    // main isolate with spawn/copy work (visible as frame spikes in DevTools).
    const chunkSize = 16;
    for (var start = 0; start < tasks.length; start += chunkSize) {
      // Screen gone (back navigation) -> stop burning CPU + never emit
      // into a closed bloc.
      if (emit.isDone) return;
      final end = start + chunkSize < tasks.length
          ? start + chunkSize
          : tasks.length;
      final solvedChunk = await compute(
        _solveTasksIsolate,
        tasks.sublist(start, end),
      );
      if (emit.isDone) return;
      results.addAll(solvedChunk);
      solved += end - start;
      final now = DateTime.now();
      final isLast = end >= tasks.length;
      final progress = (solved * 100 / tasks.length).round();
      // Skip states nobody renders: same percent (the UI's buildWhen would
      // reject them anyway) or inside the throttle window. `results` catch
      // up in the final emit below.
      if (!isLast &&
          (progress == lastProgress ||
              now.difference(lastEmit) < throttle)) {
        continue;
      }
      lastEmit = now;
      lastProgress = progress;
      emit(
        ProcessState(
          total: tasks.length,
          solved: solved,
          isCalculating: !isLast,
          results: List.unmodifiable(results),
        ),
      );
    }

    if (emit.isDone) return;
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

/// Runs in a background isolate via [compute]: solves a batch of tasks,
/// skipping malformed fields ([ArgumentError]) and unsolvable ones (null) —
/// exactly the behavior of the previous per-task entry point.
List<SolvedModel> _solveTasksIsolate(List<TaskModel> tasks) {
  final solved = <SolvedModel>[];
  for (final task in tasks) {
    try {
      final result = solveTask(task);
      if (result != null) solved.add(result);
    } on ArgumentError {
      // Malformed field: counts toward progress, not toward results.
    }
  }
  return solved;
}
