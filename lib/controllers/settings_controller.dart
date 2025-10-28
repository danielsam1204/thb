import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  SettingsController({required this.sharedPreferences});

  final RxBool _isDarkMode = false.obs;
  final RxString _selectedLanguage = "Tamil".obs;
  final RxString _selectedFont = "Medium".obs;

  ThemeMode get theme => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  RxBool get isDarkMode => _isDarkMode;

  RxString get selectedLanguage => _selectedLanguage;

  RxString get selectedFont => _selectedFont;

  Future<void> onChangeTheme(bool value) async {
    _isDarkMode.value = value;
    Get.changeThemeMode(theme);
    await sharedPreferences.setBool("theme_mode", value);
  }

  Future<void> onChangeLanguage(String? value) async {
    _selectedLanguage.value = value!;
    Locale locale;
    if (value == 'English') {
      locale = Locale('en', 'US');
    } else {
      locale = Locale('ta', 'IN');
    }
    Get.updateLocale(locale);
    String language = "${locale.languageCode}_${locale.countryCode}";
    await sharedPreferences.setString("language", language);
  }

  Future<void> onChangeFont(String? value) async {
    _selectedFont.value = value!;
    await sharedPreferences.setString("font_size", value);
  }

  initCall() {
    final languageCode = sharedPreferences.getString("language") ?? 'ta_IN';
    _selectedLanguage.value = languageCode == 'ta_IN' ? "Tamil" : "English";
  }

  double getFontScale() {
    switch (selectedFont.value) {
      case "Small":
        return 0.8;
      case "Medium":
        return 1.0;
      case "Large":
        return 1.2;
      default:
        return 1.3;
    }
  }
}
