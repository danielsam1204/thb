import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/widgets/custom_button.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class PrayerListView extends StatelessWidget {
  const PrayerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleTile(
          title: "prayer_list".tr,
          padding: EdgeInsets.only(top: 14, bottom: 10),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return prayerCard();
          },
        ),
      ],
    );
  }

  Widget prayerCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppImages.dailyManna,
              height: 75,
              width: 95,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "வாழ்த்துகள்",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
              CustomText(
                text: "பல பல வாழ்த்துகள்",

                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              CustomButton(
                label: "read_more".tr,
                margin: EdgeInsets.only(top: 6),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
