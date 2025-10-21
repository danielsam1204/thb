import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/screens/home/vedio_screen.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';
import 'package:thb/screens/home/widgets/posters_widget.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CustomTitleTile(title: "videos".tr),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            width: double.infinity,
            child: DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerHeight: 0,
                labelPadding: EdgeInsets.only(right: 6),
                labelColor: AppColors.fontOffWhiteColor,
                unselectedLabelColor: AppColors.primaryColor,
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) => Colors.transparent,
                ),
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                tabs: [
                  customOptionCard(label: "try".tr),
                  customOptionCard(label: 'encouragement'.tr),
                  customOptionCard(label: 'love'.tr),
                  customOptionCard(label: 'emotion'.tr),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoScreen()),
          ),
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

        SizedBox(
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 0, 6, 0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: videoCard(),
              );
            },
          ),
        ),
      ],
    );
  }
}
