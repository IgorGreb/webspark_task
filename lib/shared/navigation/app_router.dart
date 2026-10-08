import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/components/home_page/widget/bloc_provider/home_bloc_provider.dart';
import 'package:webspark_task/components/not_found/view/not_found_view.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

abstract class KRoute {
  static const home = (name: 'home', path: '/');
}

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: kDebugMode,
  initialLocation: KRoute.home.path,
  errorBuilder: (context, state) => const NotFoundView(),
  routes: [
    GoRoute(
      name: KRoute.home.name,
      path: KRoute.home.path,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: HomeBlocProvider(),
      ),
    ),
  ],
);
