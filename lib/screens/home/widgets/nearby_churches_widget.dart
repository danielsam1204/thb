import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class NearbyChurchesWidget extends StatelessWidget {
  const NearbyChurchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleTile(title: "churches_nearby".tr),
        const SizedBox(height: 10),
        Container(
          margin: EdgeInsets.fromLTRB(14, 4, 14, 10),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage("assets/image/home/daily_promise.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
