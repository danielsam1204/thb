import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? AppColors.redColor : AppColors.primaryColor,
      message: message,
      maxWidth: 500,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 100),
      borderRadius: 5.0,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}