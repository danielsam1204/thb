import 'package:flutter/material.dart';
import 'package:thb/domain/helpers/theme/custom_themes/custom_app_bar_theme.dart';
import 'package:thb/domain/helpers/theme/custom_themes/custom_time_picker_theme.dart';

import '../../../common/app_color.dart';

class AppTheme {
  // 🌞 Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.orange,
    scaffoldBackgroundColor: AppColors.bgLightColor,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    timePickerTheme: CustomTimePickerTheme.lightTimerPickerTheme,
    // const AppBarTheme(
    //   backgroundColor: AppColors.orange,
    //   foregroundColor: Colors.white,
    // ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.orangeLight,
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    timePickerTheme: CustomTimePickerTheme.darkTimerPickerTheme,

    // appBarTheme: const AppBarTheme(
    //   backgroundColor: AppColors.darkBrown,
    //   foregroundColor: Colors.white,
    // ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orangeLight,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );
}
