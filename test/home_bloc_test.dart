import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart';
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
  FakeUrlRepository({this.url, this.saveFailure});

  String? url;
  SomeFailure? saveFailure;

  @override
  Either<SomeFailure, String?> getUrl() => Right(url);

  @override
  Future<Either<SomeFailure, void>> saveUrl(String url) async {
    final failure = saveFailure;
    if (failure != null) return Left(failure);
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
  int fetchCalls = 0;
  List<SubmitRequestModel>? lastSubmitted;

  @override
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(
    String baseUrl,
  ) async {
    fetchCalls++;
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
  test('invalid url stays on home with invalidUrl, no fetch', () async {
    final path = FakePathRepository(tasks: [_task('a')]);
    final bloc = HomeBloc(FakeUrlRepository(), path)
      ..add(const HomeEvent.urlChanged('not a url'))
      ..add(const HomeEvent.submitted());

    final failed = await bloc.stream.firstWhere(
      (s) => s.status == HomeStatus.failure,
    );
    expect(failed.failure, SomeFailure.invalidUrl);
    expect(path.fetchCalls, 0);
    await bloc.close();
  });

  test('offline on submit stays on home with network failure', () async {
    final path = FakePathRepository(fetchFailure: SomeFailure.network);
    final bloc = HomeBloc(FakeUrlRepository(), path)
      ..add(HomeEvent.urlChanged(_validUrl))
      ..add(const HomeEvent.submitted());

    final failed = await bloc.stream.firstWhere(
      (s) => s.status == HomeStatus.failure,
    );
    // No navigation: success is never emitted, failure carries tasks=null.
    expect(failed.failure, SomeFailure.network);
    expect(failed.tasks, isNull);
    expect(path.fetchCalls, 1);
    await bloc.close();
  });

  test('valid submit preloads tasks and succeeds', () async {
    final path = FakePathRepository(tasks: [_task('a')]);
    final urls = FakeUrlRepository();
    final bloc = HomeBloc(urls, path)
      ..add(HomeEvent.urlChanged(_validUrl))
      ..add(const HomeEvent.submitted());

    final done = await bloc.stream.firstWhere(
      (s) => s.status == HomeStatus.success,
    );
    expect(done.failure, isNull);
    expect(done.tasks, hasLength(1));
    expect(urls.url, _validUrl);
    await bloc.close();
  });

  test('try again after offline recovers and succeeds', () async {
    final path = FakePathRepository(
      tasks: [_task('a')],
      fetchFailure: SomeFailure.network,
    );
    final bloc = HomeBloc(FakeUrlRepository(), path)
      ..add(HomeEvent.urlChanged(_validUrl))
      ..add(const HomeEvent.submitted());

    final failed = await bloc.stream.firstWhere(
      (s) => s.status == HomeStatus.failure,
    );
    expect(failed.failure, SomeFailure.network);

    path.fetchFailure = null;
    bloc.add(const HomeEvent.submitted());
    final done = await bloc.stream.firstWhere(
      (s) => s.status == HomeStatus.success,
    );

    expect(done.tasks, hasLength(1));
    expect(path.fetchCalls, 2);
    await bloc.close();
  });
}
