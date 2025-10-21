import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';

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
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
