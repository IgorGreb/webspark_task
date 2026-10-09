// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart'
    as _i160;
import 'package:webspark_task/components/preview/bloc/preview_bloc.dart'
    as _i904;
import 'package:webspark_task/components/process_page/bloc/process_bloc.dart'
    as _i517;
import 'package:webspark_task/shared/di/network_module.dart' as _i145;
import 'package:webspark_task/shared/di/storage_module.dart' as _i830;
import 'package:webspark_task/shared/repositories/i_path_repository.dart'
    as _i374;
import 'package:webspark_task/shared/repositories/i_url_repository.dart'
    as _i646;
import 'package:webspark_task/shared/repositories/path_repository.dart'
    as _i285;
import 'package:webspark_task/shared/repositories/url_repository.dart' as _i94;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i904.PreviewBloc>(() => _i904.PreviewBloc());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => networkModule.client);
    gh.lazySingleton<_i646.IUrlRepository>(
      () => _i94.UrlRepository(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i374.IPathRepository>(
      () => _i285.PathRepository(gh<_i519.Client>()),
    );
    gh.factory<_i160.HomeBloc>(
      () => _i160.HomeBloc(gh<_i646.IUrlRepository>()),
    );
    gh.factory<_i517.ProcessBloc>(
      () => _i517.ProcessBloc(
        gh<_i646.IUrlRepository>(),
        gh<_i374.IPathRepository>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i830.StorageModule {}

class _$NetworkModule extends _i145.NetworkModule {}
