import 'package:dartz/dartz.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';

abstract class IPathRepository {
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(String baseUrl);

  Future<Either<SomeFailure, List<SubmitResponseModel>>> submitResults(
    String baseUrl,
    List<SubmitRequestModel> results,
  );
}
