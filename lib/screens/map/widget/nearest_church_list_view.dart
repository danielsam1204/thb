import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/map_controller.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class NearestChurchListView extends StatelessWidget {
  const NearestChurchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (controller) {
        final list = controller.nearestChurchList;
        return list.isEmpty
            ? SizedBox()
            : SizedBox(
          height: list.length == 1
              ? 140
              : list.length == 2
              ? 270
              : 390,
          child: ListView.builder(
            itemCount: controller.nearestChurchList.length,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            itemBuilder: (context, index) {
              double scale = 1.0;
              final data = controller.nearestChurchList[index];
              return Opacity(
                opacity: scale,
                child: Transform(
                  transform: Matrix4.identity()..scale(scale, scale),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        if (data.photos != null &&
                            data.photos!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: FadeInImage.assetNetwork(
                              height: 95,
                              width: 115,
                              fit: BoxFit.cover,
                              placeholder: AppImages.churchPlaceholder,
                              image:
                              data.photos!.first.photoReference ?? '',
                              imageErrorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                  AppImages.churchPlaceholder,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          )
                        else
                          Container(
                            height: 95,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                image: AssetImage(
                                  AppImages.churchPlaceholder,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: data.name ?? '-',
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                maxLines: 2,
                              ),
                              CustomText(
                                text: data.vicinity ?? '-',
                                color: AppColors.primaryColor,
                                fontSize: 11,
                                maxLines: 2,
                              ),
                              starRating(data.rating ?? 0.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget starRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double starValue = index + 1;
        if (rating >= starValue) {
          return Padding(
            padding: const EdgeInsets.all(2),
            child: CustomSvgIcon(icon: AppIcons.starFilled , size: 18),
          );
        } else if (rating > starValue - 1 && rating < starValue) {
          return Padding(
            padding: const EdgeInsets.all(2),
            child: CustomSvgIcon(icon: AppIcons.starHalfFilled, size: 22),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(2),
            child: CustomSvgIcon(icon: AppIcons.starOutline, size: 22),
          );
        }
      }),
    );
  }
}