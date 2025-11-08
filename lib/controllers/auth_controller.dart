import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/dashboard.dart';
import 'package:thb/widgets/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  AuthController({required this.sharedPreferences});

  /// Login Controller
  late TextEditingController emailCon;
  late TextEditingController passwordCon;

  /// SignUp Controller
  late TextEditingController signUpEmailCon;

  late TextEditingController signUpPasswordCon;

  late TextEditingController confirmPasswordCon;

  late TextEditingController phoneNumCon;

  late TextEditingController nameCon;

  bool _signUpPasswordVisibility = false;
  bool _signUpConfirmPasswordVisibility = false;
  bool _loginPasswordVisibility = false;

  bool get signUpPasswordVisibility => _signUpPasswordVisibility;

  bool get signUpConfirmPasswordVisibility => _signUpConfirmPasswordVisibility;

  bool get loginPasswordVisibility => _loginPasswordVisibility;

  void onChangeSignUpPasswordVisibility() {
    _signUpPasswordVisibility = !signUpPasswordVisibility;
    update();
  }

  void onChangeSignUpConfirmPasswordVisibility() {
    _signUpConfirmPasswordVisibility = !signUpConfirmPasswordVisibility;
    update();
  }

  void onChangeLoginPasswordVisibility() {
    _loginPasswordVisibility = !loginPasswordVisibility;
    update();
  }

  void onTapLogin() {
    FocusScope.of(Get.context!).unfocus();
    String email = emailCon.text.trim();
    String password = passwordCon.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty || password.isEmpty) {
      showCustomSnackBar('Please fill in all fields');
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      showCustomSnackBar('Please enter a valid email address');
      return;
    }

    if (password.length < 6) {
      showCustomSnackBar('Password must be at least 6 characters');
      return;
    }

    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(builder: (context) => Dashboard()),
      (Route<dynamic> route) => false,
    );
  }

  void onTapSignUp() {
    FocusScope.of(Get.context!).unfocus();

    String name = nameCon.text.trim();
    String email = signUpEmailCon.text.trim();
    String password = signUpPasswordCon.text.trim();
    String confirmPassword = confirmPasswordCon.text.trim();
    String phone = phoneNumCon.text.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (name.isEmpty) {
      showCustomSnackBar('Please enter name');
      return;
    }

    if (name.length < 3) {
      showCustomSnackBar('Please enter a valid name (min 3 characters)');
      return;
    }
    if (email.isEmpty) {
      showCustomSnackBar('Please enter email address');
      return;
    }
    if (!emailRegex.hasMatch(email)) {
      showCustomSnackBar('Please enter a valid email address');
      return;
    }
    if (phone.isNotEmpty && phone.length < 10) {
      showCustomSnackBar('Please enter a valid phone number');
      return;
    }
    if (password.isEmpty) {
      showCustomSnackBar('Please enter password');
      return;
    }
    if (password.length < 6) {
      showCustomSnackBar('Password must be at least 6 characters');
      return;
    }
    if (confirmPassword.isEmpty) {
      showCustomSnackBar('Please enter Confirm Password');
      return;
    }
    if (password != confirmPassword) {
      showCustomSnackBar('Password and Confirm Password do not match');
      return;
    }

    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(builder: (context) => Dashboard()),
      (Route<dynamic> route) => false,
    );
  }

  void signUpInitCall() {
    signUpEmailCon = TextEditingController();
    signUpPasswordCon = TextEditingController();
    confirmPasswordCon = TextEditingController();
    phoneNumCon = TextEditingController();
    nameCon = TextEditingController();
  }

  void signUpDisposeCall() {
    signUpEmailCon.dispose();
    signUpPasswordCon.dispose();
    confirmPasswordCon.dispose();
    phoneNumCon.dispose();
  }

  void loginInitCall() {
    emailCon = TextEditingController();
    passwordCon = TextEditingController();
  }

  void loginDisposeCall() {
    emailCon.dispose();
    passwordCon.dispose();
  }
}
