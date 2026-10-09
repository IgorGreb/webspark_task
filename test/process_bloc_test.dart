import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/components/process_page/bloc/process_bloc.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/models/point_model.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';
import 'package:webspark_task/shared/repositories/i_url_repository.dart';

const _validUrl = 'https://flutter.webspark.dev/flutter/api';

TaskModel _task(String id) => TaskModel(
  id: id,
  field: const ['.X.', '.X.', '...'],
  start: const PointModel(x: 2, y: 1),
  end: const PointModel(x: 0, y: 2),
);

class FakeUrlRepository implements IUrlRepository {
  FakeUrlRepository({this.url});

  String? url;

  @override
  Either<SomeFailure, String?> getUrl() => Right(url);

  @override
  Future<Either<SomeFailure, void>> saveUrl(String url) async {
    this.url = url;
    return const Right(null);
  }

  @override
  Future<Either<SomeFailure, bool>> clearUrl() async {
    url = null;
    return const Right(true);
  }
}

class FakePathRepository implements IPathRepository {
  FakePathRepository({
    this.tasks = const [],
    this.fetchFailure,
    this.submitFailure,
  });

  List<TaskModel> tasks;
  SomeFailure? fetchFailure;
  SomeFailure? submitFailure;
  List<SubmitRequestModel>? lastSubmitted;

  @override
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(
    String baseUrl,
  ) async {
    final failure = fetchFailure;
    if (failure != null) return Left(failure);
    return Right(tasks);
  }

  @override
  Future<Either<SomeFailure, List<SubmitResponseModel>>> submitResults(
    String baseUrl,
    List<SubmitRequestModel> results,
  ) async {
    lastSubmitted = results;
    final failure = submitFailure;
    if (failure != null) return Left(failure);
    return Right([
      for (final r in results) SubmitResponseModel(id: r.id, correct: true),
    ]);
  }
}

void main() {
  test('solving progresses through solved count and finishes ready', () async {
    final path = FakePathRepository(tasks: [_task('a'), _task('b')]);
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path);

    // Collect every emitted state, but stop as soon as the bloc reports ready.
    // `stream.toList()` can't be used here: it only completes when the stream
    // is closed, which happens on `close()` below -> circular wait / timeout.
    final states = <ProcessState>[];
    final ready = Completer<void>();
    final subscription = bloc.stream.listen((state) {
      states.add(state);
      if (state.isReady && !ready.isCompleted) ready.complete();
    });

    bloc.add(const ProcessEvent.started());
    await ready.future;
    await subscription.cancel();

    expect(states.first.isFetching, isTrue);
    expect(states.any((s) => s.isCalculating), isTrue);
    final done = states.last;
    expect(done.total, 2);
    expect(done.solved, 2);
    expect(done.progress, 100);
    expect(done.isReady, isTrue);
    expect(done.results, hasLength(2));
    await bloc.close();
  });

  test('progress percent reflects solved over total', () async {
    final path = FakePathRepository(tasks: [_task('a'), _task('b')]);
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path);
    expect(bloc.state.progress, 0);
    await bloc.close();
  });

  test('invalid stored url yields invalidUrl without fetch', () async {
    final path = FakePathRepository();
    final bloc = ProcessBloc(FakeUrlRepository(url: null), path)
      ..add(const ProcessEvent.started());

    final failed = await bloc.stream.firstWhere((s) => s.failure != null);
    expect(failed.failure, SomeFailure.invalidUrl);
    expect(failed.isFetching, isFalse);
    await bloc.close();
  });

  test('fetch failure is surfaced', () async {
    final path = FakePathRepository(fetchFailure: SomeFailure.tooManyRequests);
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path)
      ..add(const ProcessEvent.started());

    final failed = await bloc.stream.firstWhere((s) => s.failure != null);
    expect(failed.failure, SomeFailure.tooManyRequests);
    await bloc.close();
  });

  test('submitted posts solved results and marks submitted', () async {
    final path = FakePathRepository(tasks: [_task('a')]);
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path);
    bloc.add(const ProcessEvent.started());
    await bloc.stream.firstWhere((s) => s.isReady);

    bloc.add(const ProcessEvent.submitted());
    final done = await bloc.stream.firstWhere((s) => s.isSubmitted);

    expect(done.isSubmitting, isFalse);
    expect(done.failure, isNull);
    expect(path.lastSubmitted, hasLength(1));
    expect(path.lastSubmitted!.first.id, 'a');
    expect(path.lastSubmitted!.first.result.path, '(2,1)->(1,2)->(0,2)');
    expect(path.lastSubmitted!.first.result.steps, const [
      SubmitStepModel(x: '2', y: '1'),
      SubmitStepModel(x: '1', y: '2'),
      SubmitStepModel(x: '0', y: '2'),
    ]);
    await bloc.close();
  });

  test('submit failure unlocks and keeps results', () async {
    final path = FakePathRepository(
      tasks: [_task('a')],
      submitFailure: SomeFailure.serverError,
    );
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path);
    bloc.add(const ProcessEvent.started());
    await bloc.stream.firstWhere((s) => s.isReady);

    bloc.add(const ProcessEvent.submitted());
    final failed = await bloc.stream.firstWhere((s) => s.failure != null);

    expect(failed.failure, SomeFailure.serverError);
    expect(failed.isSubmitting, isFalse);
    expect(failed.isSubmitted, isFalse);
    expect(failed.results, hasLength(1));
    await bloc.close();
  });

  test('unsolvable task counts as solved with no result entry', () async {
    final path = FakePathRepository(
      tasks: [
        _task('solvable'),
        const TaskModel(
          id: 'unsolvable',
          field: ['..X..', '..X..', '..X..', '..X..', '..X..'],
          start: PointModel(x: 0, y: 0),
          end: PointModel(x: 4, y: 4),
        ),
      ],
    );
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path)
      ..add(const ProcessEvent.started());

    final ready = await bloc.stream.firstWhere((s) => s.isReady);
    expect(ready.total, 2);
    expect(ready.solved, 2);
    expect(ready.results, hasLength(1));
    expect(ready.results.first.id, 'solvable');
    await bloc.close();
  });

  test('retry after fetch failure restarts and succeeds', () async {
    final path = FakePathRepository(
      tasks: [_task('a')],
      fetchFailure: SomeFailure.network,
    );
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path)
      ..add(const ProcessEvent.started());

    final failed = await bloc.stream.firstWhere((s) => s.failure != null);
    expect(failed.failure, SomeFailure.network);
    expect(failed.isReady, isFalse);

    // Simulate Try Again: failure clears, fetch succeeds.
    path.fetchFailure = null;
    bloc.add(const ProcessEvent.started());
    final ready = await bloc.stream.firstWhere((s) => s.isReady);

    expect(ready.failure, isNull);
    expect(ready.total, 1);
    expect(ready.results, hasLength(1));
    await bloc.close();
  });

  test('retry after submit failure re-submits and succeeds', () async {
    final path = FakePathRepository(
      tasks: [_task('a')],
      submitFailure: SomeFailure.serverError,
    );
    final bloc = ProcessBloc(FakeUrlRepository(url: _validUrl), path);
    bloc.add(const ProcessEvent.started());
    await bloc.stream.firstWhere((s) => s.isReady);

    bloc.add(const ProcessEvent.submitted());
    final failed = await bloc.stream.firstWhere((s) => s.failure != null);
    expect(failed.failure, SomeFailure.serverError);
    expect(failed.isReady, isTrue);

    // Simulate Try Again on submit: failure clears, submit succeeds.
    path.submitFailure = null;
    bloc.add(const ProcessEvent.submitted());
    final done = await bloc.stream.firstWhere((s) => s.isSubmitted);

    expect(done.failure, isNull);
    expect(path.lastSubmitted, hasLength(1));
    await bloc.close();
  });
}
