import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final void Function(int)? onTap;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? padding;

  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.labelPadding, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 14),
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      dividerHeight: 0,
      labelPadding: labelPadding ?? EdgeInsets.only(right: 6),
      labelColor: AppColors.fontOffWhiteColor,
      unselectedLabelColor: AppColors.primaryColor,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => Colors.transparent,
      ),
      indicator: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      onTap: onTap,
      tabs: tabs,
    );
  }
}
