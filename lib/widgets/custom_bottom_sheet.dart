import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/widgets/custom_text.dart';

Future<void> customBottomSheet({
  String? title,
  PreferredSize? appBarBottom,
  required Widget body,
  double? height,
  Widget? bottomNavBar,
  Function? then,
  Color? backgroundColor,
}) async {
  double screenHeight = MediaQuery.of(Get.context!).size.height;
  await showModalBottomSheet(
    context: Get.context!,
    builder: (context) {
      return SizedBox(
        height: height ?? screenHeight * 0.72,
        child: Scaffold(
          backgroundColor: AppColors.transparentColor,
          resizeToAvoidBottomInset: false,
          appBar: title != null
              ? AppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  title: CustomText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  actions: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 15, 12),
                        child: Icon(Icons.clear, size: 18),
                      ),
                    ),
                  ],
                  bottom: appBarBottom,
                )
              : null,
          body: Column(
            children: [
              Expanded(child: body),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: MediaQuery.of(context).viewInsets.bottom * 0.72,
              ),
            ],
          ),
          bottomNavigationBar: bottomNavBar != null
              ? BottomAppBar(
                  elevation: 9,
                  shadowColor: AppColors.greyColor,
                  height: 70,
                  child: bottomNavBar,
                )
              : const SizedBox(),
        ),
      );
    },
    backgroundColor: backgroundColor,
    isScrollControlled: true,
  ).then((val) {
    then?.call(val);
  });
}
