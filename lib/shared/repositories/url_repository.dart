import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webspark_task/shared/models/failure_model/failure_model.dart';
import 'package:webspark_task/shared/repositories/i_url_repository.dart';

@LazySingleton(as: IUrlRepository)
class UrlRepository implements IUrlRepository {
  UrlRepository(this._prefs);

  final SharedPreferences _prefs;

  static const String urlKey = 'api_base_url';

  @override
  Future<Either<SomeFailure, void>> saveUrl(String url) {
    return eitherFutureHelper(
      () async {
        final ok = await _prefs.setString(urlKey, url.trim());
        if (!ok) return const Left(SomeFailure.serverError);
        return const Right(null);
      },
      methodName: 'saveUrl',
      className: 'UrlRepository',
    );
  }

  @override
  Either<SomeFailure, String?> getUrl() {
    try {
      return Right(_prefs.getString(urlKey));
    } catch (_) {
      return const Left(SomeFailure.unknown);
    }
  }

  @override
  Future<Either<SomeFailure, bool>> clearUrl() {
    return eitherFutureHelper(
      () async => Right(await _prefs.remove(urlKey)),
      methodName: 'clearUrl',
      className: 'UrlRepository',
    );
  }
}
