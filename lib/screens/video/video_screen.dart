import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/screens/video/video_description_screen.dart';
import 'package:thb/screens/video/widget/video_widget.dart';
import 'package:thb/widgets/bubble_page_route.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "videos".tr,
        onTap: () => Navigator.pop(context),
      ),
      body: VideoWidget(fromHome: false),
    );
  }
}

Widget videoGridView() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(14),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.84,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return videoCard();
        },
      ),
    ),
  );
}

Widget videoListView() {
  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(14, 0, 6, 0),
    itemCount: 5,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: videoCard(),
      );
    },
  );
}

Widget videoCard() {
  final size = MediaQuery.of(Get.context!).size;
  final width = size.width;
  return GestureDetector(
    onTapDown: (details) {
      final tapPosition = details.globalPosition;
      Navigator.push(
        Get.context!,
        BubblePageRoute(
          position: tapPosition,
          builder: (context) => const VideoDescriptionScreen(),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(10),
      width: width * 0.43,
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 76,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: AssetImage(AppImages.dailyManna),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomText(
              maxLines: 2,
              color: AppColors.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              text:
                  "வலிமையாகவும் தைரியமாகவும் இரு; பயப்படாதே, ஆதங்கப்படாதே; எங்கே போனாலும் உங்கள் தேவனாகிய கர்த்தர் உன்னோடே இருப்பார்.",
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor,
            ),
            child: Center(
              child: CustomSvgIcon(icon: AppIcons.playFilled, size: 16),
            ),
          ),
        ],
      ),
    ),
  );
}
