import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'favorite', onTap: ()=> Navigator.pop(context),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              commentaryWidget(),
              SizedBox(height: 10),
              imageWidget(),
              SizedBox(height: 10),
              songWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentaryWidget() {
    return Column(
      children: [
        CustomTitleTile(
          title: "உரை",
          action: CustomText(
            text: "Clear",
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return favCard(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(AppImages.dailyManna),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 40,
                      width: 45,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CustomText(
                        maxLines: 2,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                        text:
                            "23. தேவன் ஆகாய விரிவை உண்டு பண்ணி, ஆகாயவிரிவுக்குக் கீழே இருக்கிற ஜலத்திற்கும் ஆகாயவிரிவுக்கு மேலே இருக்கிற ஜலத்திற்கும் பிரிவுண்டாக்கினார்; அது அப்படியே ஆயிற்று.",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget imageWidget() {
    return Column(
      children: [
        CustomTitleTile(
          title: "படம்",
          action: CustomText(
            text: "Clear",
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return favCard(
              child: Container(
                height: 140,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/image/home/daily_promise.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget songWidget() {
    return Column(
      children: [
        CustomTitleTile(
          title: "பாடல்கள்",
          action: CustomText(
            text: "Clear",
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 6),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return favCard(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "அக்கினி அபிஷேகம் ஈந்திடும்",
                      color: AppColors.primaryColor,
                      maxLines: 2,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: "Album:அவரை துதியுங்கள்",
                            fontSize: 12,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        CustomText(
                          text: "Language:தமிழ்",
                          fontSize: 12,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget favCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.bgColor,
      ),
      child: Column(
        children: [
          child,
          Row(
            children: [
              CustomSvgIcon(icon: AppIcons.favoriteFilled, size: 16),
              Spacer(),
              CustomText(
                text: "Not now",
                fontSize: 10,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
