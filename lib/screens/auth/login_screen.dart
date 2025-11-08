import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/common/app_icons.dart';
import 'package:thb/common/app_images.dart';
import 'package:thb/controllers/auth_controller.dart';
import 'package:thb/screens/auth/sign_up_screen.dart';
import 'package:thb/widgets/custom_button.dart';
import 'package:thb/widgets/custom_svg_icon.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.loginInitCall();
  }

  @override
  void dispose() {
    controller.loginDisposeCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
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
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppImages.logo,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomText(
                      text: "மின்னஞ்சல் ஐடி",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "john@example.com",
                      controller: controller.emailCon,
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      text: "கடவுச்சொல்",
                      color: AppColors.fontOffWhiteColor,
                    ),
                    SizedBox(height: 6),
                    CustomTextFormField(
                      hintText: "......",
                      obscureText: !controller.loginPasswordVisibility
                          ? true
                          : false,
                      controller: controller.passwordCon,
                      suffixIcon: GestureDetector(
                        onTap: controller.onChangeLoginPasswordVisibility,
                        child: Icon(
                          !controller.loginPasswordVisibility
                              ? AppIcons.visibility
                              : AppIcons.visibilityOff,
                          size: 18,
                          color: AppColors.offWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          text: "கடவுச்சொல்லை மறந்துவிட்டீர்களா?",
                          fontSize: 10,
                          color: AppColors.fontOffWhiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    CustomButton(
                      onTap: controller.onTapLogin,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      label: "உள்நுழையவும்",
                      labelSize: 16,
                      labelWeight: FontWeight.w600,
                      backgroundColor: AppColors.bgLightColor,
                      labelColor: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: CustomText(
                              text: "அல்லது இதன்மூலம் உள்நுழையுங்கள்",
                              fontSize: 10,
                              color: AppColors.fontOffWhiteColor,
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          socialMediaButton(
                            icon: AppIcons.googleIcon,
                            onTap: () {},
                          ),
                          SizedBox(width: 10),
                          socialMediaButton(
                            icon: AppIcons.appleIcon,
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 20),
                      child: Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: CustomText(
                              text: "அல்லது",
                              fontSize: 10,
                              color: AppColors.fontOffWhiteColor,
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      padding: EdgeInsets.symmetric(vertical: 12),
                      label: "புதிய கணக்கை உருவாக்குங்கள்",
                      labelSize: 13,
                      labelWeight: FontWeight.w500,
                      backgroundColor: AppColors.transparentColor,
                      labelColor: AppColors.fontOffWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      borderColor: AppColors.offWhite,
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

  Widget socialMediaButton({
    required String icon,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 45,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.bgLightColor,
        ),
        child: CustomSvgIcon(icon: icon),
      ),
    );
  }
}
