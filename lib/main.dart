import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/controllers/settings_controller.dart';
import 'package:thb/dashboard.dart';
import 'package:thb/domain/helpers/get_dep.dart' as dep;
import 'package:thb/domain/helpers/language.dart';

import 'domain/helpers/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  final prefs = Get.find<SharedPreferences>();
  final settingsController = Get.find<SettingsController>();
  await settingsController.onChangeTheme(prefs.getBool("theme_mode") ?? false);
  await settingsController.onChangeFont(
    prefs.getString("font_size") ?? "Medium",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Get.find<SharedPreferences>();
    final language = prefs.getString("language") ?? 'ta_IN';
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.find<SettingsController>().theme,
      locale: Locale(language),
      translations: Language(),
      fallbackLocale: Locale("ta_IN"),
      // home: Dashboard(),
      home: ()
    );
  }
}
// https://maps.googleapis.com/maps/api/place/autocomplete/json?input=porur&key=AIzaSyCi2q9rEJ0LUgbgw7aD49U_o-q_UX8LDC0
