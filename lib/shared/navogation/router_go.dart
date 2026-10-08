import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webspark_task/components/home_page/view/home_view.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

abstract class KRoute {
  static const home = (name: 'home', path: '/');
}

GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: KRoute.home.path,
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Page not found'))),
  routes: [
    GoRoute(
      name: KRoute.home.name,
      path: KRoute.home.path,
      builder: (context, state) => const Home(),
    ),
  ],
);
