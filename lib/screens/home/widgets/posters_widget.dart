import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/screens/home/poster_screen.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class PostersWidget extends StatelessWidget {
  const PostersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CustomTitleTile(title: "posters".tr),
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
            MaterialPageRoute(builder: (context) => PosterScreen()),
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
          height: 140,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 0, 6, 0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 12),
                width: width * 0.43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/image/home/daily_promise.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget customOptionCard({required String label}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.primaryColor),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: CustomText(text: label, fontSize: 12),
  );
}
