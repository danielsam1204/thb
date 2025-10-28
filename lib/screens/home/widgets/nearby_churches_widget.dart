import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/home_controller.dart';
import 'package:thb/screens/home/map_screen.dart';
import 'package:thb/widgets/bubble_page_route.dart';
import 'package:thb/widgets/custom_button.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class NearbyChurchesWidget extends StatelessWidget {
  const NearbyChurchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        CustomTitleTile(title: "churches_nearby".tr),
        const SizedBox(height: 10),
        GestureDetector(
          onTapDown: (details) => controller.onTapChurchContainer(details),
          child: Container(
            margin: EdgeInsets.fromLTRB(14, 4, 14, 10),
            padding: EdgeInsets.all(14),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(AppImages.church),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "பாறையின் மீது நான் என் திருச்சபையை கட்டுவேன்",
                  color: AppColors.fontOffWhiteColor,
                  maxLines: 4,
                  fontSize: 12,
                ),
                CustomButton(
                  onTap: () {},
                  label: "இப்போது கண்டுபிடி",
                  backgroundColor: AppColors.transparentColor,
                  borderColor: AppColors.fontOffWhiteColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
