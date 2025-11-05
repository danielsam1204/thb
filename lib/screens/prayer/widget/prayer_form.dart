import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/widgets/custom_bottom_sheet.dart';
import 'package:thb/widgets/custom_button.dart';
import 'package:thb/widgets/custom_text.dart';

class PrayerForm extends StatelessWidget {
  const PrayerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "enter_a_title".tr,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
        Card(
          color: AppColors.bgColor,
          margin: EdgeInsets.only(top: 4, bottom: 10),
          child: TextField(
            cursorColor: AppColors.primaryColor,
            cursorWidth: 1.5,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
        ),
        CustomText(
          text: "add_details_about_your_prayer".tr,
          fontWeight: FontWeight.w500,
          maxLines: 2,
          color: AppColors.primaryColor,
        ),
        Card(
          color: AppColors.bgColor,
          margin: EdgeInsets.only(top: 4, bottom: 10),
          child: TextField(
            cursorColor: AppColors.primaryColor,
            cursorWidth: 1.5,
            maxLines: 100,
            minLines: 5,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
        ),
        CustomButton(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          padding: EdgeInsets.symmetric(vertical: 10),
          label: "submit".tr,
          labelSize: 14,
          labelWeight: FontWeight.w600,
          onTap: () {
            customBottomSheet(
              backgroundColor: AppColors.whiteColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.thanksImg, height: 200, width: 200),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 14,
                    ),
                    child: CustomText(
                      maxLines: 10,
                      textAlign: TextAlign.center,
                      color: AppColors.primaryColor,
                      text:
                      "thank_you_for_sending_a_prayer_request_we_are_praying_for_the_prayers_you_mentioned"
                          .tr,
                    ),
                  ),
                  IntrinsicWidth(
                    child: CustomButton(
                      onTap: () => Navigator.pop(context),
                      label: "thank_you".tr,
                      labelWeight: FontWeight.w500,
                      labelSize: 14,
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 6,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}