import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/controllers/settings_controller.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.fontFamily,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Obx(() {
      final scale = settingsController.getFontScale();
      final fontScale = (fontSize ?? 14) * scale;
      return Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontScale,
          color: color,
        ),
      );
    });
  }
}
