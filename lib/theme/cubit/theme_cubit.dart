import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pub_chem/theme/models/app_theme_mode.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit() : super(AppThemeMode.system) {
    _loadTheme();
  }

  static const String _themeKey = 'app_theme_mode';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey);
      if (themeIndex != null && themeIndex >= 0 && themeIndex < AppThemeMode.values.length) {
        emit(AppThemeMode.values[themeIndex]);
      }
    } catch (e) {
      // If loading fails, use system default
      emit(AppThemeMode.system);
    }
  }

  Future<void> setTheme(AppThemeMode theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
      emit(theme);
    } catch (e) {
      // If saving fails, still update the state
      emit(theme);
    }
  }

  ThemeMode getThemeMode() {
    switch (state) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
