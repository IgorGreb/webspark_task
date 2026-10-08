import 'package:dartz/dartz.dart';
import 'package:webspark_task/shared/models/failure_model/some_failure.dart';

// ignore: one_member_abstracts
abstract class IUrlRepository {
  Future<Either<SomeFailure, void>> saveUrl(String url);
  Either<SomeFailure, String?> getUrl();
  Future<Either<SomeFailure, bool>> clearUrl();
}
