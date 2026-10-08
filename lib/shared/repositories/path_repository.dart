import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:webspark_task/shared/models/failure_model/failure_model.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';

/// Expected OK status of the API responses.
const int _statusOk = 200;

@LazySingleton(as: IPathRepository)
class PathRepository implements IPathRepository {
  PathRepository(this._client);

  final http.Client _client;

  @override
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(String baseUrl) {
    return eitherFutureHelper(
      () async {
        final uri = Uri.parse(baseUrl.trim());
        final response = await _client.get(uri);

        if (response.statusCode != _statusOk) {
          return Left(failureFromStatusCode(response.statusCode));
        }

        final decoded = _decodeObject(response.body);
        if (decoded == null) return const Left(SomeFailure.format);

        if (decoded['error'] == true) {
          return const Left(SomeFailure.serverError);
        }

        final data = decoded['data'];
        if (data is! List) return const Left(SomeFailure.format);

        final tasks = <TaskModel>[];
        for (final item in data) {
          if (item is! Map<String, dynamic>) {
            return const Left(SomeFailure.format);
          }
          tasks.add(TaskModel.fromJson(item));
        }
        return Right(tasks);
      },
      methodName: 'fetchTasks',
      className: 'PathRepository',
    );
  }

  @override
  Future<Either<SomeFailure, List<SubmitResponseModel>>> submitResults(
    String baseUrl,
    List<SubmitRequestModel> results,
  ) {
    return eitherFutureHelper(
      () async {
        final uri = Uri.parse(baseUrl.trim());
        final response = await _client.post(
          uri,
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode(results.map((e) => e.toJson()).toList()),
        );

        if (response.statusCode != _statusOk) {
          return Left(failureFromStatusCode(response.statusCode));
        }

        final decoded = _decodeObject(response.body);
        if (decoded == null) return const Left(SomeFailure.format);

        if (decoded['error'] == true) {
          return const Left(SomeFailure.serverError);
        }

        final data = decoded['data'];
        if (data is! List) return const Left(SomeFailure.format);

        final items = <SubmitResponseModel>[];
        for (final item in data) {
          if (item is! Map<String, dynamic>) {
            return const Left(SomeFailure.format);
          }
          items.add(SubmitResponseModel.fromJson(item));
        }
        return Right(items);
      },
      methodName: 'submitResults',
      className: 'PathRepository',
    );
  }

  Map<String, dynamic>? _decodeObject(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      return null;
    } on FormatException {
      return null;
    }
  }
}
