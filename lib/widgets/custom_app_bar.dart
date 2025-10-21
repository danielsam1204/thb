import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/controllers/dashboard_controller.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.bottomWidget,
    this.actions,
    this.onTap,
  });

  final String? title;
  final PreferredSizeWidget? bottomWidget;
  final List<Widget>? actions;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return AppBar(
      titleSpacing: 0,
      title: CustomText(
        text: title ?? '',
        fontSize: 18,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      actions: actions,
      leading: GestureDetector(
        onTap: onTap ?? () => controller.onChangeIndex(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.0),
          child: CustomSvgIcon(icon: AppIcons.arrowBackwardFilled),
        ),
      ),
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottomWidget?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
