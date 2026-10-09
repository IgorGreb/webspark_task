import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:webspark_task/shared/models/failure_model/failure_model.dart';
import 'package:webspark_task/shared/models/submit_model.dart';
import 'package:webspark_task/shared/models/task_model.dart';
import 'package:webspark_task/core/validators/url_validator.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';

const int _statusOk = 200;

const Duration _requestTimeout = Duration(seconds: 15);

/// Hard caps so a hostile server cannot OOM the phone.
const int _maxResponseBytes = 5 * 1024 * 1024;
const int _maxTasks = 500;
const int _maxFieldSize = 99;
const int _maxIdLength = 128;

@injectable
class PathRepository implements IPathRepository {
  PathRepository(this._client);

  final http.Client _client;

  @override
  Future<Either<SomeFailure, List<TaskModel>>> fetchTasks(String baseUrl) {
    return eitherFutureHelper(
      () async {
        final uri = _safeUri(baseUrl);
        if (uri == null) return const Left(SomeFailure.invalidUrl);

        // No auto-redirects: a 3xx that points elsewhere is a failure, so a
        // hostile server cannot bounce us (and our results) to another host.
        final request = http.Request('GET', uri)..followRedirects = false;
        request.headers['Accept'] = 'application/json';
        final streamed = await _client.send(request).timeout(_requestTimeout);
        final response = await _toResponse(streamed);
        if (response == null) return const Left(SomeFailure.format);

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
        if (data.length > _maxTasks) return const Left(SomeFailure.format);

        final tasks = <TaskModel>[];
        for (final item in data) {
          if (item is! Map<String, dynamic>) {
            return const Left(SomeFailure.format);
          }
          final task = _parseTask(item);
          if (task == null) return const Left(SomeFailure.format);
          tasks.add(task);
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
        final uri = _safeUri(baseUrl);
        if (uri == null) return const Left(SomeFailure.invalidUrl);
        if (results.length > _maxTasks) {
          return const Left(SomeFailure.format);
        }

        final request = http.Request('POST', uri)..followRedirects = false;
        request.headers['Content-Type'] = 'application/json';
        request.headers['Accept'] = 'application/json';
        request.body = jsonEncode(results.map((e) => e.toJson()).toList());
        final streamed = await _client.send(request).timeout(_requestTimeout);
        final response = await _toResponse(streamed);
        if (response == null) return const Left(SomeFailure.format);

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

  /// Null unless the URL is well-formed, public-routable and same rules as UI.
  Uri? _safeUri(String baseUrl) {
    final trimmed = baseUrl.trim();
    if (!UrlValidator.isSafeForRequest(trimmed)) return null;
    return Uri.tryParse(trimmed);
  }

  /// Reads a streamed response with a hard byte cap; null when oversized.
  Future<http.Response?> _toResponse(http.StreamedResponse streamed) async {
    final contentLength = streamed.contentLength;
    if (contentLength != null && contentLength > _maxResponseBytes) {
      await streamed.stream.drain<void>();
      return null;
    }
    var bytes = 0;
    final chunks = <List<int>>[];
    await for (final chunk in streamed.stream) {
      bytes += chunk.length;
      if (bytes > _maxResponseBytes) return null;
      chunks.add(chunk);
    }
    final bodyBytes = chunks.expand((c) => c).toList();
    return http.Response.bytes(
      bodyBytes,
      streamed.statusCode,
      headers: streamed.headers,
    );
  }

  /// Strict DTO guard: wrong shape / oversized payload rejected as format.
  TaskModel? _parseTask(Map<String, dynamic> json) {
    try {
      final id = json['id'];
      final field = json['field'];
      final start = json['start'];
      final end = json['end'];
      if (id is! String || id.isEmpty || id.length > _maxIdLength) {
        return null;
      }
      if (field is! List ||
          field.isEmpty ||
          field.length > _maxFieldSize ||
          field.any((row) => row is! String)) {
        return null;
      }
      final rows = field.cast<String>();
      final n = rows.length;
      if (n < 2 || n > _maxFieldSize) return null;
      for (final row in rows) {
        if (row.length != n) return null;
        for (var i = 0; i < row.length; i++) {
          final c = row[i];
          if (c != '.' && c != 'X') return null;
        }
      }
      if (start is! Map<String, dynamic> || end is! Map<String, dynamic>) {
        return null;
      }
      return TaskModel.fromJson(json);
    } on FormatException {
      return null;
    } on ArgumentError {
      return null;
    } on TypeError {
      return null;
    }
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
