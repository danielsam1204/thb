import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon({super.key, required this.icon, this.size, this.color});

  final String icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: size ?? 24,
      width: size ?? 24,
      color: color,
    );
  }
}
