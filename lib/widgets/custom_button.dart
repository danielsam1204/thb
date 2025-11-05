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
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final double? width;
  final FontWeight? labelWeight;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.labelSize,
    this.labelColor,
    this.backgroundColor,
    this.padding,
    this.borderColor,
    this.width,
    this.labelWeight,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        margin: margin,
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
          fontWeight: labelWeight,
          color: labelColor ?? AppColors.fontOffWhiteColor,
        ),
      ),
    );
  }
}
