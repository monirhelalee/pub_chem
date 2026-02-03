import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/router/app_routes.dart';
import 'package:pub_chem/splash/view/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
