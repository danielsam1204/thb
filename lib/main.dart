import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/screens/landing_page.dart';
import 'package:thb/splash.dart';

import 'domain/helpers/app_theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Load saved language from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final String? langCode = prefs.getString('languageCode');

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ta'),
      ],
      path: 'assets/data/language',
      fallbackLocale: const Locale('en'),
      startLocale: langCode != null ? Locale(langCode) : const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashScreen(),
    );
  }
}
