import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/controllers/map_controller.dart';
import 'package:thb/widgets/custom_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapController>();
    final height = MediaQuery.of(context).size.height;
    return Container(
      key: const ValueKey('searchView'),
      height: double.infinity,
      width: double.infinity,
      color: AppColors.bgLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: height * 0.2),
          InkWell(
            onTap: controller.onTapCurrentPosition,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    AppIcons.myLocation,
                    color: AppColors.primaryColor,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: "current_location".tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Divider(thickness: 0.4, color: Colors.grey.shade400),
          GetBuilder<MapController>(
            builder: (controller) {
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: controller.searchData.length,
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = controller.searchData[index];
                    return InkWell(
                      onTap: () async => await controller.getPlaceCoordinates(
                        data.placeId ?? '',
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                AppIcons.locationOnOutlined,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: data.description ?? '-',
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text:
                                    data
                                        .structuredFormatting!
                                        .secondaryText ??
                                        '-',
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(AppIcons.northWest, size: 18),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(thickness: 0.4, color: Colors.grey.shade400),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}