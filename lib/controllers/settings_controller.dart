import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  SettingsController({required this.sharedPreferences});

  Future<void> changeLanguage(Locale locale) async {
    Get.updateLocale(locale);
    String language = "${locale.languageCode}_${locale.countryCode}";
    await sharedPreferences.setString("language", language);
  }

  // ta_IN
}
