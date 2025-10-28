import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';

class DailyMannaScreen extends StatelessWidget {
  const DailyMannaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "daily_manna".tr,
        onTap: (){
          Navigator.pop(context);
        },
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSvgIcon(icon: AppIcons.favoriteOutline, size: 20),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSvgIcon(icon: AppIcons.share),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                  ),
                  child: CustomText(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    maxLines: 4,
                    text:
                        "எட்டாம் நாளிலே அந்தப் பிள்ளையினுடைய நுனித்தோலின் மாம்சம் விருத்தசேதனம்பண்ணப்படக்கடவது.",
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomText(
                      text: "-லேவியராகமம் 17:16",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                CustomText(
                  maxLines: 1000,
                  fontSize: 13,
                  text:
                      "இந்த வசனம், இஸ்ரவேல் மக்கள் "
                      "தேவனோடு கொண்டிருந்த உடன்படிக்கையை (covenant) குறிக்கிறது. "
                      "அந்த உடன்படிக்கையின் வெளிப்படையான அடையாளமாகவே விருத்தசேதனம் "
                      "(circumcision) இருந்தது. இது ஒரு குழந்தையின் வாழ்க்கையில் தேவனுடன் சேர்ந்த "
                      "உறவை ஆரம்பிக்கும் சின்னமாகக் கருதப்பட்டது. ஏழு நாட்கள் கழித்து, எட்டாவது நாளில்"
                      " விருத்தசேதனம் செய்யப்பட வேண்டும் என்று தேவன் கட்டளையிட்டார்."
                      "இந்த உடல்புறச் சின்னம், உள்ளத்தின் சழ்ச்சி (spiritual circumcision) "
                      "என்பதற்கான முன்னோடியாகவும் இருந்தது. அதாவது, பவம், துக்கம், "
                      "பழைய இயல்பு ஆகியவற்றை அகற்றி, தேவனுக்கு உகந்த வாழ்வை ஆரம்பிப்பது.புதிய"
                      " ஏற்பாட்டில், விருத்தசேதனம் தேவையில்லை என்று பவுல் தெளிவாகக்கூறுகிறார் "
                      "(உதா: கலாத்தியர் 5:6), ஆனால் உள்ளத்தினுடைய சத்திரத்திறை என்பதே முக்கியமானது. "
                      "இன்று தேவன் விரும்புவது — நம் உள்ளத்தை சுத்திகரித்து, நம் வாழ்வை அவருக்காக"
                      " வெறுப்ம் தியாகத்துக்குப் பயனுள்ளதாக்குவது.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
