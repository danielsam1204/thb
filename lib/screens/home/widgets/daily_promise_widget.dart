import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_switch.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';
import 'package:thb/controllers/home_controller.dart';

class DailyPromiseWidget extends StatelessWidget {
  const DailyPromiseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerHeight: 0,
                    labelColor: AppColors.fontOffWhiteColor,
                    unselectedLabelColor: AppColors.primaryColor,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: CustomText(
                          text: "picture".tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: CustomText(
                          text: "text".tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
        SizedBox(
          height: 150,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(14, 0, 6, 0),
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
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
            },
          ),
        ),
      ],
    );
  }
}
