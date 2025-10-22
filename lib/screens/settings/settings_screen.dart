import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/controllers/settings_controller.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_switch.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final controller = Get.find<SettingsController>();

  @override
  void initState() {
    super.initState();
    controller.initCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "settings".tr,
        onTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          CustomTitleTile(title: "language".tr),
          languageSettingsCard(label: 'tamil'.tr, value: "Tamil"),
          languageSettingsCard(label: 'english'.tr, value: "English"),
          SizedBox(height: 10),
          CustomTitleTile(title: "theme".tr),
          Obx(
            () => settingsCard(
              label: "dark_mode".tr,
              value: controller.isDarkMode.value,
              onChanged: controller.onChangeTheme,
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsCard({
    required String label,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            color: AppColors.primaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          Transform.scale(
            scale: 0.6,
            child: CustomSwitch(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }

  Widget languageSettingsCard({required String label, required String value}) {
    final controller = Get.find<SettingsController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            color: AppColors.primaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          Obx(
            () => Radio(
              value: value,
              onChanged: controller.onChangeLanguage,
              activeColor: AppColors.primaryColor,
              groupValue: controller.selectedLanguage.value,
            ),
          ),
        ],
      ),
    );
  }
}
