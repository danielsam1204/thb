import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/widgets/custom_svg_icon.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool disableAction;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.padding,
    this.color,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.disableAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(14, 0, 14, 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              child: TextField(
                onTap: onTap,
                controller: controller,
                onChanged: onChanged,
                cursorColor: AppColors.primaryColor,
                cursorWidth: 1.5,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 0,
                  ),
                  hintText: hintText ?? "search".tr,
                  hintStyle: TextStyle(color: AppColors.greyColor),
                  filled: true,
                  fillColor: color ?? AppColors.bgColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomSvgIcon(icon: AppIcons.search, size: 20),
                  ),
                  suffixIcon: suffixIcon,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          if (!disableAction) ...{
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: CustomSvgIcon(
                icon: AppIcons.search,
                color: AppColors.whiteColor,
                size: 14,
              ),
            ),
          },
        ],
      ),
    );
  }
}
