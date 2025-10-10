import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController {
  ValueNotifier<Locale> locale = ValueNotifier(Locale('en', 'US'));

  // Load saved language from SharedPreferences
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language_code') ?? 'en';
    final country = prefs.getString('country_code') ?? 'US';
    locale.value = Locale(code, country);
  }

  // Change language and save to SharedPreferences
  Future<void> changeLanguage(Locale newLocale) async {
    locale.value = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
    await prefs.setString('country_code', newLocale.countryCode ?? '');
  }
}