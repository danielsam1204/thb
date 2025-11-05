import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/controllers/settings_controller.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_button.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleTile(title: "prayer_list".tr),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              margin: EdgeInsets.fromLTRB(14, 10, 14, 12),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 95,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/image/home/daily_promise.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "give_your_needs_to_the_lord".tr,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          maxLines: 2,
                        ),
                        SizedBox(height: 8),
                        CustomButton(label: "get_started".tr),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // CustomTitleTile(title: "theme".tr),
            // Obx(
            //   () => settingsCard(
            //     label: "dark_mode".tr,
            //     value: controller.isDarkMode.value,
            //     onChanged: controller.onChangeTheme,
            //   ),
            // ),
            // SizedBox(height: 10),
            CustomTitleTile(title: "letter_setting".tr),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: CustomText(
                text: "letter_size".tr,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            fontSettingsCard(label: 'small'.tr, value: "Small"),
            fontSettingsCard(label: 'medium'.tr, value: "Medium"),
            fontSettingsCard(label: 'large'.tr, value: "Large"),
            fontSettingsCard(label: 'extra_large'.tr, value: "Extra Large"),
            SizedBox(height: 10),
            CustomTitleTile(title: "language".tr),
            languageSettingsCard(label: 'tamil'.tr, value: "Tamil"),
            languageSettingsCard(label: 'english'.tr, value: "English"),
          ],
        ),
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

  Widget fontSettingsCard({required String label, required String value}) {
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
              onChanged: controller.onChangeFont,
              activeColor: AppColors.primaryColor,
              groupValue: controller.selectedFont.value,
            ),
          ),
        ],
      ),
    );
  }
}
