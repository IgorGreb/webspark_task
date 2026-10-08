// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:webspark_task/components/home_page/bloc/home_bloc.dart'
    as _i160;
import 'package:webspark_task/shared/di/storage_module.dart' as _i830;
import 'package:webspark_task/shared/repositories/i_url_repository.dart'
    as _i646;
import 'package:webspark_task/shared/repositories/url_repository.dart' as _i94;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i646.IUrlRepository>(
      () => _i94.UrlRepository(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i160.HomeBloc>(
      () => _i160.HomeBloc(gh<_i646.IUrlRepository>()),
    );
    return this;
  }
}

class _$StorageModule extends _i830.StorageModule {}
