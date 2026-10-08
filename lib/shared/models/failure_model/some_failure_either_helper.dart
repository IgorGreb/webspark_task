import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';

Future<Either<SomeFailure, T>> eitherFutureHelper<T>(
  Future<Either<SomeFailure, T>> Function() function, {
  required String methodName,
  required String className,
}) async {
  try {
    return await function();
  } on http.ClientException {
    return const Left(SomeFailure.network);
  } on FormatException {
    return const Left(SomeFailure.format);
  } catch (e) {
    if (e.toString().contains('SocketException') ||
        e.toString().contains('Connection')) {
      return const Left(SomeFailure.network);
    }
    return const Left(SomeFailure.unknown);
  }
}

SomeFailure failureFromStatusCode(int statusCode) {
  switch (statusCode) {
    case 401:
    case 403:
      return SomeFailure.unauthorized;
    case 404:
      return SomeFailure.dataNotFound;
    case 408:
      return SomeFailure.timeout;
    case 429:
      return SomeFailure.tooManyRequests;
    case 500:
    case 502:
    case 503:
      return SomeFailure.serverError;
    default:
      return SomeFailure.unknown;
  }
}
