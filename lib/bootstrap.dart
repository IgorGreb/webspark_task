import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:webspark_task/app.dart';
import 'package:webspark_task/shared/di/injection.dart';
import 'package:webspark_task/shared/observer/app_bloc_observer.dart';

/// Bootstrap of the application.
///
/// Single entry-point for all pre-`runApp` initialization:
///   1. Global error handling ([FlutterError.onError] + [runZonedGuarded])
///      so no exception is lost silently.
///   2. [Bloc.observer] for logging events / transitions / errors.
///   3. [WidgetsFlutterBinding.ensureInitialized] for `await`s before UI.
///   4. Dependency injection via [configureDependencies] (get_it).
///   5. Place for async init: Firebase, HydratedStorage, dotenv, prefs, ...
///
/// Used by `lib/main.dart` (and future flavor entry-points like
/// `main_development.dart` / `main_production.dart`).
Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await configureDependencies();

    runApp(const App());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}
