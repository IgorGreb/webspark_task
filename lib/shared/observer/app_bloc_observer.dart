import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global observer for all BLoCs/Cubits in the app.
///
/// Wired up in [bootstrap] (see `lib/bootstrap.dart`).
/// In debug it prints events / transitions / errors,
/// in release it stays silent (forward to Crashlytics/Sentry here).
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      debugPrint('BLOC EVENT  | ${bloc.runtimeType} | $event');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint('BLOC CHANGE | ${bloc.runtimeType} | $change');
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      debugPrint('BLOC TRANS  | ${bloc.runtimeType} | $transition');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('BLOC ERROR  | ${bloc.runtimeType} | $error\n$stackTrace');
    }
    super.onError(bloc, error, stackTrace);
  }
}
