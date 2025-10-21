import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/widgets/custom_text.dart';

class QAndAScreen extends StatelessWidget {
  const QAndAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightColor,
      body: Center(
        child: CustomText(text: "QAndA Screen"),
      ),
    );
  }
}
