class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String more = '/more';
  static const String navbar = '/navbar';

  static const List<String> allRoutes = [
    splash,
    home,
    more,
  ];

  static bool isValidRoute(String route) {
    return allRoutes.contains(route);
  }
}
