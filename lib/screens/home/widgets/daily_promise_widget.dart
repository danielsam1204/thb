import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_switch.dart';
import 'package:thb/widgets/custom_tab_bar.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';
import 'package:thb/controllers/home_controller.dart';
import 'package:thb/widgets/custom_vertical_divider.dart';

class DailyPromiseWidget extends StatelessWidget {
  const DailyPromiseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleTile(title: "daily_promise".tr),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.bgColor,
                  ),
                  child: CustomTabBar(
                    onTap: controller.onChangeDailyPromiseTab,
                    labelPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    tabs: [_tab("picture".tr), _tab("text".tr)],
                  ),
                ),
              ),
              Spacer(),
              GetBuilder<HomeController>(
                builder: (controller) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: controller.pickTime,
                    child: Container(
                      color: AppColors.bgLightColor,
                      child: Row(
                        children: [
                          CustomSvgIcon(icon: AppIcons.clockOutline, size: 14),
                          SizedBox(width: 4),
                          CustomText(
                            text: controller.selectTime ?? '-',
                            color: AppColors.primaryColor,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              GetBuilder<HomeController>(
                builder: (controller) {
                  return Transform.scale(
                    scale: 0.6,
                    child: CustomSwitch(
                      value: controller.isToggle,
                      onChanged: controller.onChangeSwitch,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        GetBuilder<HomeController>(
          builder: (controller) {
            int tabIndex = controller.dailyPromiseTabIndex;
            return SizedBox(
              height: tabIndex == 0 ? 150 : 200,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(14, 0, 6, 0),
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return tabIndex == 0 ? pictureCard() : textCard();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget pictureCard() {
    final width = MediaQuery.of(Get.context!).size.width;
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/image/home/daily_promise.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget textCard() {
    final width = MediaQuery.of(Get.context!).size.width;
    return Container(
      width: width * 0.85,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customVerticalDivider(width: 2, height: 20),
              SizedBox(width: 6),
              CustomText(
                text: "Today",
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomText(
                maxLines: 100,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.primaryColor,
                text:
                    "23. தேவன் ஆகாய விரிவை உண்டு பண்ணி, ஆகாயவிரிவுக்குக்"
                    " கீழே இருக்கிற ஜலத்திற்கும் ஆகாயவிரிவுக்கு மேலே இருக்கிற ஜலத்திற்கும் பிரிவுண்டாக்கினார்; அது அப்படியே ஆயிற்று.",
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomText(
              text: "-லேவியராகமம் 17:16",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: CustomText(text: label, fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}
