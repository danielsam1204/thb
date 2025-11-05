import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/dashboard_controller.dart';
import 'package:thb/controllers/profile_controller.dart';
import 'package:thb/screens/song/song_screen.dart';
import 'package:thb/screens/video/video_screen.dart';
import 'package:thb/screens/settings/settings_screen.dart';
import 'package:thb/widgets/bubble_page_route.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(onTap: () => Navigator.pop(context)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              GetBuilder<ProfileController>(
                builder: (controller) {
                  return Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 92,
                          width: 92,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          // child: FadeInImage.assetNetwork(
                          //   fit: BoxFit.cover,
                          //   placeholder: AppImages.placeholder,
                          //   image: controller.profileImage ?? '',
                          //   imageErrorBuilder: (context, error, stackTrace) {
                          //     print("erroe --->> $error");
                          //     return Image.asset(
                          //       AppImages.placeholder,
                          //       fit: BoxFit.cover,
                          //     );
                          //   },
                          // ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: controller.pickImage,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.bgColor,
                              ),
                              child: CustomSvgIcon(
                                icon: AppIcons.camera,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.pop(context);
                  Get.find<DashboardController>().onChangeIndex(1);
                },
              ),
              titleCard(
                icon: AppIcons.quizzesFilled,
                title: 'quizzes'.tr,
                onTap: () {},
              ),
              titleCard(
                icon: AppIcons.music,
                title: 'songs'.tr,
                onTapDown: (details) {
                  final tapPosition = details.globalPosition;
                  Navigator.push(
                    context,
                    BubblePageRoute(
                      builder: (context) => SongScreen(),
                      position: tapPosition,
                    ),
                  );
                },
              ),
              titleCard(
                icon: AppIcons.videoFilled,
                title: 'videos'.tr,
                onTapDown: (details) {
                  final tapPosition = details.globalPosition;
                  Navigator.push(
                    Get.context!,
                    BubblePageRoute(
                      position: tapPosition,
                      builder: (context) => const VideoScreen(),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.pop(context);
                  Get.find<DashboardController>().onChangeIndex(3);
                },
              ),
              // titleCard(
              //   icon: AppIcons.prayerFilled,
              //   title: 'prayer_list'.tr,
              //   onTap: () {
              //     Navigator.pop(context);
              //     Get.find<DashboardController>().onChangeIndex(3);
              //   },
              // ),
              titleCard(
                icon: AppIcons.qAndAFilled,
                title: 'q_and_a'.tr,
                onTap: () {
                  Navigator.pop(context);
                  Get.find<DashboardController>().onChangeIndex(4);
                },
              ),
              titleCard(
                icon: AppIcons.settingFilled,
                title: 'settings'.tr,
                onTapDown: (details) {
                  final tapPosition = details.globalPosition;
                  Navigator.push(
                    Get.context!,
                    BubblePageRoute(
                      position: tapPosition,
                      builder: (context) => const SettingsScreen(),
                    ),
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
    void Function()? onTap,
    void Function(TapDownDetails)? onTapDown,
  }) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
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
