import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: .fromSeed(
        seedColor: Colors.blue,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: .5,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: .fromSeed(
        seedColor: Colors.blue,
        brightness: .dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: .5,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12),
        ),
      ),
    );
  }
}
