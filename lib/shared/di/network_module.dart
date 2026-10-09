import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:webspark_task/shared/repositories/i_path_repository.dart';
import 'package:webspark_task/shared/repositories/mock_path_repository.dart';
import 'package:webspark_task/shared/repositories/path_repository.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  http.Client get client => http.Client();

  /// Debug harness first: `mock://...` is served locally, everything else
  /// falls through to the hardened HTTP repository.
  @lazySingleton
  IPathRepository pathRepository(PathRepository real) =>
      MockAwarePathRepository(real);
}
