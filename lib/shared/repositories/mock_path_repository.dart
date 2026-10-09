import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:webspark_task/features/mocks/mock_tasks.dart';
import 'package:webspark_task/shared/models/failure_model/failure_model.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';
import 'package:webspark_task/shared/repositories/path_repository.dart';

/// Debug-only decorator: intercepts `mock://...` URLs and serves generated
/// tasks locally with an artificial delay, so progress 0→100% can be watched
/// without a server: `mock://small|medium|large|stress` or
/// `mock://tasks?count=150&size=30&seed=7&fetchMs=800`.
///
/// Release builds are unaffected: [isMockUrl] short-circuits only when
/// [kDebugMode] is true, otherwise the call falls through to the real repo
/// (which rejects `mock://` as invalid).
///
/// Registered manually from [NetworkModule.pathRepository], NOT via
/// `@LazySingleton` (that would register `IPathRepository` twice and break
/// the injectable generator).
class MockAwarePathRepository implements IPathRepository {
  MockAwarePathRepository(this._real);

  final PathRepository _real;

  @override
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(String baseUrl) {
    final config = kDebugMode ? MockTasks.parse(baseUrl.trim()) : null;
    if (config == null) return _real.fetchTasks(baseUrl);
    return eitherFutureHelper(
      () async {
        await Future<void>.delayed(config.fetchDelay);
        return Right(
          MockTasks.generate(
            count: config.count,
            size: config.size,
            seed: config.seed,
          ),
        );
      },
      methodName: 'fetchTasks.mock',
      className: 'MockAwarePathRepository',
    );
  }

  @override
  Future<Either<SomeFailure, List<SubmitResponseModel>>> submitResults(
    String baseUrl,
    List<SubmitRequestModel> results,
  ) {
    final config = kDebugMode ? MockTasks.parse(baseUrl.trim()) : null;
    if (config == null) return _real.submitResults(baseUrl, results);
    // Emulate a server that accepts everything after a short delay.
    return eitherFutureHelper(
      () async {
        await Future<void>.delayed(config.submitDelay);
        return Right([
          for (final r in results) SubmitResponseModel(id: r.id, correct: true),
        ]);
      },
      methodName: 'submitResults.mock',
      className: 'MockAwarePathRepository',
    );
  }
}
