import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;

  const CustomSwitch({super.key, required this.value,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeTrackColor: AppColors.primaryColor,
      inactiveTrackColor: AppColors.bgLightColor,
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.offWhite;
        } else {
          return AppColors.primaryColor;
        }
      }),
      trackOutlineColor: MaterialStateProperty.resolveWith(
        (states) => AppColors.primaryColor,
      ),
      value: value,
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    );
  }
}
