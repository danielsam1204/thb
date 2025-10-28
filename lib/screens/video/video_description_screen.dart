import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_title_tile.dart';

class VideoDescriptionScreen extends StatelessWidget {
  const VideoDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "videos".tr,
        onTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(14)
            ),
            width: double.infinity,
            height: 200,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTitleTile(title: "வலிமையாகவும் தைரியமாகவும்"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: CustomText(
                      maxLines: 1000,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      text:
                      "ஆதாம் என்பது முதல் மனிதனின் தனிப்பட்ட பெயராகவும், மனிதகுலத்தின் அடையாளமாகவும் உள்ளது. ஆதாம் மற்றும் ஏவாவுக்கு இந்தப் பெயரை தந்தவர் தேவனே ஆவார் (உற்பத்தி 5:1–2). ஆதாம் என்ற எபிரேயச் சொல்லின் வேர் பொருள் சிகப்பு என்பதாகும். இது அவர் உருவான சிவந்த மண்ணைக் குறிக்கலாம்."
                          "ஆதாம் என்பது முதல் மனிதனின் தனிப்பட்ட பெயராகவும், மனிதகுலத்தின் அடையாளமாகவும் உள்ளது. ஆதாம் மற்றும் ஏவாவுக்கு இந்தப் பெயரை தந்தவர் தேவனே ஆவார் (உற்பத்தி 5:1–2). ஆதாம் என்ற எபிரேயச் சொல்லின் வேர் பொருள் சிகப்பு என்பதாகும். இது அவர் உருவான சிவந்த மண்ணைக் குறிக்கலாம்."
                          "ஆதாம் என்பது முதல் மனிதனின் தனிப்பட்ட பெயராகவும், மனிதகுலத்தின் அடையாளமாகவும் உள்ளது. ஆதாம் மற்றும் ஏவாவுக்கு இந்தப் பெயரை தந்தவர் தேவனே ஆவார் (உற்பத்தி 5:1–2). ஆதாம் என்ற எபிரேயச் சொல்லின் வேர் பொருள் சிகப்பு என்பதாகும். இது அவர் உருவான சிவந்த மண்ணைக் குறிக்கலாம்."
                          "ஆதாம் என்பது முதல் மனிதனின் தனிப்பட்ட பெயராகவும், மனிதகுலத்தின் அடையாளமாகவும் உள்ளது. ஆதாம் மற்றும் ஏவாவுக்கு இந்தப் பெயரை தந்தவர் தேவனே ஆவார் (உற்பத்தி 5:1–2). ஆதாம் என்ற எபிரேயச் சொல்லின் வேர் பொருள் சிகப்பு என்பதாகும். இது அவர் உருவான சிவந்த மண்ணைக் குறிக்கலாம்."
                          "ஆதாம் என்பது முதல் மனிதனின் தனிப்பட்ட பெயராகவும், மனிதகுலத்தின் அடையாளமாகவும் உள்ளது. ஆதாம் மற்றும் ஏவாவுக்கு இந்தப் பெயரை தந்தவர் தேவனே ஆவார் (உற்பத்தி 5:1–2). ஆதாம் என்ற எபிரேயச் சொல்லின் வேர் பொருள் சிகப்பு என்பதாகும். இது அவர் உருவான சிவந்த மண்ணைக் குறிக்கலாம்.",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}






