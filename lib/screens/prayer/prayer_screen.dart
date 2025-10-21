import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "prayer_list".tr),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.symmetric(horizontal: 14 , vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.bgColor,
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: "no_prayers_have_been_added_yet".tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.primaryColor,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      child: CustomText(
                        text: "add_a_prayer".tr,
                        color: AppColors.fontOffWhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomSvgIcon(icon: AppImages.prayer, size: 250),
          ),
        ],
      ),
    );
  }
}
