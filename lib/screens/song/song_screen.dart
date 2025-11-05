import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_bottom_sheet.dart';
import 'package:thb/widgets/custom_search_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppbar(
        title: "songs".tr,
        onTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleTile(
                title: "அவரின் பாடல்கள்புகள்",
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 180,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => customBottomSheet(
                      height: height * 0.8,
                      body: songBottomSheetBody(context),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              width: double.infinity,
                              height: 130,
                              AppImages.dailyManna,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          CustomText(
                            text: "அவரை துதியுங்கள்",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget songBottomSheetBody(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
                child: CustomSvgIcon(icon: AppIcons.arrowBack, size: 20),
              ),
            ),
            Expanded(child: CustomSearchBar()),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.bgLightColor,
                  borderRadius: BorderRadius.circular(8),
                ),

                child: CustomText(
                  text: "${index + 1}.அக்கினி",
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
