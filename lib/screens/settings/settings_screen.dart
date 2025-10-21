import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/controllers/settings_controller.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return Scaffold(
      appBar: CustomAppbar(
        title: "settings".tr,
        onTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => controller.changeLanguage(Locale('ta', 'IN')),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Tamil"),
            ),
          ),
          GestureDetector(
            onTap: () => controller.changeLanguage(Locale('en', 'US')),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "English"),
            ),
          ),
        ],
      ),
    );
  }
}
