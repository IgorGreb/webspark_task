import 'package:get_it/get_it.dart';

/// Global service locator.
///
/// Register app-wide dependencies here (repositories, use-cases,
/// navigation helpers, etc.) and call [configureDependencies]
/// from `bootstrap()` before `runApp()`.
final GetIt getIt = GetIt.instance;

/// Registers all app dependencies.
///
/// Safe to call multiple times (e.g. in tests) — already
/// registered types are skipped via `allowReassignment: false`
/// + `isRegistered` guards.
Future<void> configureDependencies() async {
  // TODO(homepage_flow): register repositories / blocs, e.g.:
  // if (!getIt.isRegistered<AppRouter>()) {
  //   getIt.registerSingleton<AppRouter>(AppRouter());
  // }
}
