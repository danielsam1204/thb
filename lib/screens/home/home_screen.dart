import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/home_controller.dart';
import 'package:thb/screens/favorite/favorite_screen.dart';
import 'package:thb/screens/profile/profile_screen.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/screens/home/widgets/category_widget.dart';
import 'package:thb/screens/home/widgets/daily_promise_widget.dart';
import 'package:thb/screens/home/widgets/nearby_churches_widget.dart';
import 'package:thb/screens/home/widgets/posters_widget.dart';
import 'package:thb/screens/home/widgets/video_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.initCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 45,
        leading: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: CustomSvgIcon(icon: AppIcons.menu),
          ),
        ),
        titleSpacing: 0,
        title: CustomText(
          text: "holy_bible".tr,
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoriteScreen()),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSvgIcon(icon: AppIcons.favoriteFilled, size: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 14, 0),
            child: CustomSvgIcon(icon: AppIcons.notificationFilled, size: 22),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        cursorColor: AppColors.primaryColor,
                        cursorWidth: 1.5,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 0,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: AppColors.greyColor),
                          filled: true,
                          fillColor: AppColors.bgColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomSvgIcon(
                              icon: AppIcons.search,
                              size: 20,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: CustomSvgIcon(
                      icon: AppIcons.search,
                      color: AppColors.whiteColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.bgColor,
              ),
              child: Row(
                children: [
                  Image.asset(AppImages.dailyManna, height: 110, width: 100),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "27 அக்டோபர், 2025",
                            fontSize: 12,
                            color: AppColors.primaryColor,
                          ),
                          CustomText(
                            text: "காலை வணக்கம் தொகை",
                            maxLines: 2,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CustomText(
                              text: "daily_manna".tr,
                              fontSize: 10,
                              color: AppColors.fontOffWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            DailyPromiseWidget(),
            const SizedBox(height: 12),
            CategoryWidget(),
            const SizedBox(height: 12),
            PostersWidget(),
            const SizedBox(height: 12),
            VideoWidget(),
            const SizedBox(height: 12),
            NearbyChurchesWidget(),
          ],
        ),
      ),
    );
  }
}
