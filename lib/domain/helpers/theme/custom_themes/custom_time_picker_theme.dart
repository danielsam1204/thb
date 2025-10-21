import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';

class CustomTimePickerTheme {
  static TimePickerThemeData lightTimerPickerTheme = TimePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => AppColors.redColor,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => AppColors.redColor,
      ),
    ),
    backgroundColor: AppColors.whiteColor,
    dialHandColor: AppColors.orange,
    hourMinuteTextColor: AppColors.orange,
    hourMinuteColor: AppColors.bgGreyColor,
    dialBackgroundColor: AppColors.bgGreyColor,
    dayPeriodColor: AppColors.bgGreyColor,
    dayPeriodBorderSide: BorderSide(color: AppColors.bgGreyColor),
  );
  static TimePickerThemeData darkTimerPickerTheme = TimePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => AppColors.redColor,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => AppColors.redColor,
      ),
    ),
    backgroundColor: AppColors.whiteColor,
    dialHandColor: AppColors.orange,
    hourMinuteTextColor: AppColors.orange,
    hourMinuteColor: AppColors.bgGreyColor,
    dialBackgroundColor: AppColors.bgGreyColor,
    dayPeriodColor: AppColors.bgGreyColor,
    dayPeriodBorderSide: BorderSide(color: AppColors.bgGreyColor),
  );
}
