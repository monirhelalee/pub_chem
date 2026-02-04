import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/router/app_routes.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.more);
    }
  }

  String _getAppBarTitle(String location) {
    if (location == AppRoutes.home) {
      return 'Home';
    } else if (location == AppRoutes.more) {
      return 'More';
    }
    return 'App';
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    var selectedIndex = 0;

    if (location == AppRoutes.home) {
      selectedIndex = 0;
    } else if (location == AppRoutes.more) {
      selectedIndex = 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(location)),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
