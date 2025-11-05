import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/screens/home/poster_screen.dart';
import 'package:thb/widgets/bubble_page_route.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_tab_bar.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class PostersWidget extends StatelessWidget {
  final bool fromHome;

  const PostersWidget({super.key, this.fromHome = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (fromHome) ...{
          CustomTitleTile(title: "posters".tr),
          const SizedBox(height: 10),
        },
        SizedBox(
          width: double.infinity,
          child: DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: CustomTabBar(
              tabs: [
                customTab(label: "try".tr),
                customTab(label: 'encouragement'.tr),
                customTab(label: 'love'.tr),
                customTab(label: 'emotion'.tr),
              ],
            ),
          ),
        ),
        if (fromHome)
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              final tapPosition = details.globalPosition;
              Navigator.push(
                Get.context!,
                BubblePageRoute(
                  position: tapPosition,
                  builder: (context) => const PosterScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: "see_all".tr,
                    fontSize: 12,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(width: 6),
                  CustomSvgIcon(icon: AppIcons.arrowForwardIOS, size: 12),
                ],
              ),
            ),
          ),
        if (fromHome)
          SizedBox(height: 140, child: posterListView())
        else
          posterGridView(),
      ],
    );
  }
}

Widget customTab({required String label}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.primaryColor),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: CustomText(text: label, fontSize: 12),
  );
}
