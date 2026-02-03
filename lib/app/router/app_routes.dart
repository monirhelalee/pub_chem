class AppRoutes {
  AppRoutes._();

  static const String splash = '/';

  static const List<String> allRoutes = [
    splash,
  ];

  static bool isValidRoute(String route) {
    return allRoutes.contains(route);
  }
}
