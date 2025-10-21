import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_vertical_divider.dart';

class CustomTitleTile extends StatelessWidget {
  final String title;
  final Widget? action;

  const CustomTitleTile({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          customVerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomText(
                text: title,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          action ?? SizedBox(),
        ],
      ),
    );
  }
}
