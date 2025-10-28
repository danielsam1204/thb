import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/screens/video/video_screen.dart';
import 'package:thb/widgets/bubble_page_route.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_tab_bar.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';
import 'package:thb/screens/home/widgets/posters_widget.dart';

class VideoWidget extends StatelessWidget {
  final bool fromHome;

  const VideoWidget({super.key, this.fromHome = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (fromHome) ...{
          CustomTitleTile(title: "videos".tr),
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
            onTapDown: (details) {
              final tapPosition = details.globalPosition;
              Navigator.push(
                Get.context!,
                BubblePageRoute(
                  position: tapPosition,
                  builder: (context) => const VideoScreen(),
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
          SizedBox(height: 190, child: videoListView())
        else
          videoGridView(),
      ],
    );
  }
}
