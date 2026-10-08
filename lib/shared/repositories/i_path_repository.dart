import 'package:dartz/dartz.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';

// ignore: one_member_abstracts
abstract class IPathRepository {
  /// GET [baseUrl] as is (query params included) -> list of tasks.
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(String baseUrl);

  /// POST [baseUrl] with solved results -> per-task correctness.
  Future<Either<SomeFailure, List<SubmitResponseModel>>> submitResults(
    String baseUrl,
    List<SubmitRequestModel> results,
  );
}
