import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/widgets/custom_snackbar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/controllers/dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (controller.currentIndex != 0) {
          controller.onChangeIndex(0);
          return;
        }
        final now = DateTime.now();
        if (lastPressed == null ||
            now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          showCustomSnackBar("Press back again to exit", isError: false);
          return;
        }
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: GetBuilder<DashboardController>(
          builder: (controller) => controller.screens[controller.currentIndex],
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.bgLightColor,
          padding: EdgeInsets.zero,
          height: 70,
          child: GetBuilder<DashboardController>(
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customBottomNavIcon(
                    label: 'Home',
                    filledIcon: AppIcons.homeFilled,
                    outlineIcon: AppIcons.homeOutline,
                    index: 0,
                  ),
                  customBottomNavIcon(
                    label: 'Read Bible',
                    filledIcon: AppIcons.readBibleFilled,
                    outlineIcon: AppIcons.readBibleOutline,
                    index: 1,
                  ),
                  customBottomNavIcon(
                    label: 'Dictionary',
                    filledIcon: AppIcons.dictionaryFilled,
                    outlineIcon: AppIcons.dictionaryOutline,
                    index: 2,
                  ),
                  customBottomNavIcon(
                    label: 'Prayer',
                    filledIcon: AppIcons.prayerFilled,
                    outlineIcon: AppIcons.prayerOutline,
                    index: 3,
                  ),
                  customBottomNavIcon(
                    label: 'Q&A',
                    filledIcon: AppIcons.qAndAFilled,
                    outlineIcon: AppIcons.qAndAOutline,
                    index: 4,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget customBottomNavIcon({
    required String label,
    required String filledIcon,
    required String outlineIcon,
    required int index,
  }) {
    final controller = Get.find<DashboardController>();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.onChangeIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        width: MediaQuery.of(Get.context!).size.width / 5,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: index == controller.currentIndex
                  ? AppColors.primaryColor
                  : AppColors.bgLightColor,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgIcon(
              icon: index == controller.currentIndex ? filledIcon : outlineIcon,
              size: 22,
              color: index == controller.currentIndex
                  ? AppColors.primaryColor
                  : AppColors.primaryLightColor,
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: CustomText(
                text: label,
                fontSize: 12,
                color: index == controller.currentIndex
                    ? AppColors.primaryColor
                    : AppColors.primaryLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
