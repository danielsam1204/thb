import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/controllers/dictionary_controller.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_search_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final controller = Get.find<DictionaryController>();

  @override
  void initState() {
    super.initState();
    controller.initCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "dictionary".tr),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<DictionaryController>(
              builder: (controller) {
                return CustomSearchBar(
                  controller: controller.searchController,
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  color: AppColors.bgLightColor,
                  suffixIcon: controller.searchController.text.isEmpty
                      ? null
                      : InkWell(
                          onTap: controller.onTapClearSearch,
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: CustomSvgIcon(
                              icon: AppIcons.clear,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                );
              },
            ),
            CustomText(
              text: "எழுத்துகள் மூலம் தேடுங்கள்",
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            GetBuilder<DictionaryController>(
              builder: (controller) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.tamilLetters.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final letter = controller.tamilLetters[index];
                    final isSelected = controller.searchLetterIndex == index;
                    return GestureDetector(
                      onTap: () => controller.onSelectLetter(index),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor : null,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: CustomText(
                          text: letter,
                          color: isSelected
                              ? AppColors.fontOffWhiteColor
                              : AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.bgLightColor,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: CustomText(
                      text: "${index + 1}.அக்கினி",
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
