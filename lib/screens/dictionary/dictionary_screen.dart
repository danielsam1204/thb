import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_text.dart';

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "dictionary".tr),
      body: Center(child: CustomText(text: "Dictionary Screen")),
    );
  }
}
