import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';
import 'package:thb/widgets/custom_vertical_divider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleTile(title: "type".tr),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              categoryOptionCard(icon: AppIcons.music, label: "songs".tr),
              SizedBox(width: 8),
              categoryOptionCard(
                icon: AppIcons.questionMarkFilled,
                label: "q_and_a".tr,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        todayReadingCard(),
      ],
    );
  }

  Widget todayReadingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.bgColor,
      ),
      child: Row(
        children: [
          Image.asset(AppImages.womenReader),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "today_reading".tr,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 4),
              CustomText(
                text: "நாள் 4 : ஆதியாகமம் 12–14",
                color: AppColors.primaryColor,
                fontSize: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: CustomText(
                  text: "continue_reading".tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryOptionCard({required String icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CustomSvgIcon(icon: icon),
          SizedBox(width: 8),
          CustomText(
            text: label,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
