import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';

class LanguageProvider extends ChangeNotifier {
  static const _prefsKey = 'app_locale';

  Locale _locale;
  Locale get locale => _locale;

  LanguageProvider({Locale? initialLocale})
      : _locale = initialLocale ?? const Locale('en') {
    AppStrings.setLocale(_locale);
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    AppStrings.setLocale(_locale);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _locale.languageCode);
  }

  static Future<Locale> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code == 'is') return const Locale('is');
    return const Locale('en');
  }
}

