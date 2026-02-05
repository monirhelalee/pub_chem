import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/app/router/app_routes.dart';
import 'package:pub_chem/compound_details/view/compound_details_screen.dart';
import 'package:pub_chem/home/view/home_screen.dart';
import 'package:pub_chem/more/view/more_screen.dart';
import 'package:pub_chem/navbar/view/navbar_view.dart';
import 'package:pub_chem/search/view/search_screen.dart';
import 'package:pub_chem/splash/view/bloc/splash_bloc.dart';
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
          return BlocProvider(
            create: (_) => sl<SplashBloc>(),
            child: const SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.more,
        name: 'more',
        builder: (BuildContext context, GoRouterState state) {
          return const MoreScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.navbar,
        name: 'navbar',
        builder: (BuildContext context, GoRouterState state) {
          return const NavbarView();
        },
      ),
      GoRoute(
        path: AppRoutes.search,
        name: 'search',
        builder: (BuildContext context, GoRouterState state) {
          return const SearchScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.compoundDetails,
        name: 'compoundDetails',
        builder: (BuildContext context, GoRouterState state) {
          final compoundName = state.extra as String? ?? '';
          return CompoundDetailsScreen(compoundName: compoundName);
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
