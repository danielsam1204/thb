import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';

Widget customVerticalDivider({double? height, double? width}) {
  return Container(
    height: height ?? 26,
    width: width ?? 3,
    color: AppColors.primaryColor,
  );
}