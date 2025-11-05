import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/prayer_controller.dart';
import 'package:thb/screens/prayer/widget/prayer_form.dart';
import 'package:thb/screens/prayer/widget/prayer_list_view.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_button.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final controller = Get.find<PrayerController>();
  late ScrollController scrollController;
  bool showAddIcon = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    controller.initCall();
  }

  void scrollListener() {
    if (scrollController.offset > 150 && !showAddIcon) {
      setState(() => showAddIcon = true);
    } else if (scrollController.offset <= 150 && showAddIcon) {
      setState(() => showAddIcon = false);
    }
  }

  void onTapAddIcon() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "prayer".tr,
        actions: [
          AnimatedOpacity(
            opacity: showAddIcon ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: showAddIcon,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: onTapAddIcon,
                  child: CustomSvgIcon(icon: AppIcons.addFilled),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<PrayerController>(
        builder: (controller) {
          return controller.showForm
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        PrayerForm(),
                        Image.asset(AppImages.verseCard, fit: BoxFit.contain),
                        PrayerListView(),
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(14),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 20,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.bgColor,
                          ),
                          child: Column(
                            children: [
                              CustomText(
                                text: "no_prayers_have_been_added_yet".tr,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.primaryColor,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              IntrinsicWidth(
                                child: CustomButton(
                                  onTap: () =>
                                      controller.onChangeShowForm(true),
                                  label: "add_a_prayer".tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CustomSvgIcon(icon: AppImages.prayer, size: 250),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
