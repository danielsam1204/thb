import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double? labelSize;
  final Color? labelColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.labelSize,
    this.labelColor,
    this.backgroundColor,
    this.padding,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          border: Border.all(
            color: borderColor ?? (backgroundColor ?? AppColors.primaryColor),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomText(
          text: label,
          fontSize: labelSize ?? 10,
          color: labelColor ?? AppColors.fontOffWhiteColor,
        ),
      ),
    );
  }
}
