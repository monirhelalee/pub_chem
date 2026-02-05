import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    unawaited(_loadLocale());
  }

  static const String _localeLanguageCodeKey = 'app_locale_language_code';

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_localeLanguageCodeKey);
      if (languageCode != null) {
        emit(Locale(languageCode));
      }
    } on Exception {
      emit(const Locale('en'));
    }
  }

  Future<void> setLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeLanguageCodeKey, locale.languageCode);
      emit(locale);
    } on Exception {
      emit(locale);
    }
  }
}
