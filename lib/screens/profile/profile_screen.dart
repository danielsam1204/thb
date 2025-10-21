import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/screens/settings/settings_screen.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(onTap: ()=> Navigator.pop(context)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 92,
                      width: 92,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bgColor,
                        ),
                        child: CustomSvgIcon(icon: AppIcons.camera, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomText(
                text: "சாமுவேல்",
                maxLines: 2,
                textAlign: TextAlign.center,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: "சென்னை, தமிழ்நாடு தொகு",
                color: AppColors.primaryColor,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              titleCard(
                icon: AppIcons.readBibleFilled,
                title: 'reading_plan'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.quizzesFilled,
                title: 'quizzes'.tr,
                onTap: () {},
              ),
              titleCard(icon: AppIcons.music, title: 'songs'.tr, onTap: () {}),
              titleCard(
                icon: AppIcons.videoFilled,
                title: 'videos'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.editFilled,
                title: 'featured_dialogues'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.squareEditFilled,
                title: 'notes'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.prayerFilled,
                title: 'prayers'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.prayerFilled,
                title: 'prayer_list'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.qAndAFilled,
                title: 'q_and_a'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.settingFilled,
                title: 'settings'.tr,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
              titleCard(
                icon: AppIcons.logoutFilled,
                title: 'log_out'.tr,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleCard({
    required String icon,
    required String title,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CustomSvgIcon(icon: icon, size: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                  text: title,
                  color: AppColors.primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomSvgIcon(icon: AppIcons.arrowForwardIOS, size: 12),
          ],
        ),
      ),
    );
  }
}
