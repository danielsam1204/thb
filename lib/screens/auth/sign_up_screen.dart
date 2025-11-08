import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/controllers/auth_controller.dart';
import 'package:thb/widgets/custom_button.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.signUpInitCall();
  }

  @override
  void dispose() {
    controller.signUpDisposeCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8.0),
            child: CustomSvgIcon(
              icon: AppIcons.arrowBackwardFilled,
              color: AppColors.bgLightColor,
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "உங்கள் கணக்கை உருவாக்க பதிவு செய்க",
                      textAlign: TextAlign.center,
                      color: AppColors.fontOffWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      maxLines: 2,
                    ),
                    SizedBox(height: 40),
                    CustomText(
                      text: "பெயர்",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "john",
                      controller: controller.nameCon,
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      text: "மின்னஞ்சல் ஐடி",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "john@example.com",
                      controller: controller.signUpEmailCon,
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      text: "கைபேசி எண் (விருப்பத்துக்கு ஏற்ப)",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "8776546789",
                      controller: controller.phoneNumCon,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      text: "கடவுச்சொல்",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "......",
                      controller: controller.signUpPasswordCon,
                      obscureText: !controller.signUpPasswordVisibility
                          ? true
                          : false,
                      suffixIcon: GestureDetector(
                        onTap: controller.onChangeSignUpPasswordVisibility,
                        child: Icon(
                          !controller.signUpPasswordVisibility
                              ? AppIcons.visibility
                              : AppIcons.visibilityOff,
                          size: 18,
                          color: AppColors.offWhite,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      text: "கடவுச்சொல்லை உறுதிப்படுத்துங்கள்",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "......",
                      controller: controller.confirmPasswordCon,
                      obscureText: !controller.signUpConfirmPasswordVisibility
                          ? true
                          : false,
                      suffixIcon: GestureDetector(
                        onTap:
                            controller.onChangeSignUpConfirmPasswordVisibility,
                        child: Icon(
                          !controller.signUpConfirmPasswordVisibility
                              ? AppIcons.visibility
                              : AppIcons.visibilityOff,
                          size: 18,
                          color: AppColors.offWhite,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      onTap: controller.onTapSignUp,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      label: "உள்நுழையவும்",
                      labelSize: 16,
                      labelWeight: FontWeight.w600,
                      backgroundColor: AppColors.bgLightColor,
                      labelColor: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
