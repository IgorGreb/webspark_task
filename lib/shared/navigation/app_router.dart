import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/components/result_list/view/result_list_view.dart';
import 'package:webspark_task/components/home_page/widget/bloc_provider/home_bloc_provider.dart';
import 'package:webspark_task/components/not_found/view/not_found_view.dart';
import 'package:webspark_task/components/process_page/widget/bloc_provider/process_bloc_provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

abstract class KRoute {
  static const home = (name: 'home', path: '/');
  static const process = (name: 'process', path: '/process');
  static const results = (name: 'results', path: '/results');
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
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeBlocProvider()),
    ),
    GoRoute(
      name: KRoute.process.name,
      path: KRoute.process.path,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ProcessBlocProvider()),
    ),
    GoRoute(
      name: KRoute.results.name,
      path: KRoute.results.path,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ResultListView()),
    ),
  ],
);
