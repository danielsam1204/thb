import 'package:flutter/material.dart';

import '../../temp_keywords.dart';
import '../../widgets/common_buttons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF441606),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:
            // loginHome(),
            // signUp(),
            RegisterPageInput(),
          ),
        ),
      ),
    );
  }

  Widget loginHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleSubTitle(title: registerlogin, subTitle: wellsomeapp),
        Image.asset("assets/image/sin-in-up/registerimage.png"),
        CustomeButton(
          text: googlelogin,
          ImageIconSize: "assets/image/sin-in-up/google_logo.png",
        ),
        CustomeButton(text: applelogin, ImageIconSize: "assets/image/sin-in-up/apple_logo.png"),
        CustomeButton(text: emaillogin, ImageIconSize: "assets/image/sin-in-up/email_logo.png"),
        TextDivider(text: alredyaccount, textontap: signup),
        CustomeButton(text: newaccountcreate, fill: false),
      ],
    );
  }

  Widget signUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleSubTitle(title: signup, subTitle: wellsomeapp),
        Image.asset("assets/image/sin-in-up/loginImage.png"),
        CustomeButton(
          text: googlelogin,
          ImageIconSize: "assets/image/sin-in-up/google_logo.png",
        ),
        CustomeButton(text: applelogin, ImageIconSize: "assets/image/sin-in-up/apple_logo.png"),
        CustomeButton(text: emaillogin, ImageIconSize: "assets/image/sin-in-up/email_logo.png"),
        TextDivider(text: orbelowlogin),
        CustomeButton(text: newaccountcreate, fill: false),
      ],
    );
  }
  //////////////////////////////////
  final _formKey = GlobalKey<FormState>();

  // controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  Future<void> submitData() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final body = {
      "name": _nameController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "password": _passwordController.text,
    };



    setState(() => _isLoading = false);
  }

  Widget RegisterPageInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TitleSubTitle(title: creataccountdetailstitle),
        SizedBox(height: 120),
        TitleSubTitle(
          subTitle: name,
          subWidget: TextFormField(
            // controller: _nameController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: textInputDecoration(name),
            validator: (value) =>
            value == null || value.isEmpty ? "Enter a name" : null,
          ),
        ),
        TitleSubTitle(
          subTitle: emailid,
          subWidget: TextFormField(
            // controller: _nameController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: textInputDecoration(emailid),
            validator: (value) =>
            value == null || value.isEmpty ? "Enter a name" : null,
          ),
        ),
        TitleSubTitle(
          subTitle: phonenumber,
          subWidget: TextFormField(
            // controller: _nameController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: textInputDecoration(phonenumber),
            validator: (value) =>
            value == null || value.isEmpty ? "Enter a name" : null,
          ),
        ),
        TitleSubTitle(
          subTitle: password,
          subWidget: TextFormField(
            // controller: _nameController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: textInputDecoration(password),
            validator: (value) =>
            value == null || value.isEmpty ? "Enter a name" : null,
          ),
        ),
        TitleSubTitle(
          subTitle: confirmpassword,
          subWidget: TextFormField(
            // controller: _nameController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: textInputDecoration(confirmpassword),
            validator: (value) =>
            value == null || value.isEmpty ? "Enter a name" : null,
          ),
        ),
        const SizedBox(height: 30),
        CustomeButton(
            onTap: _isLoading ? null : submitData,
            widget: _isLoading
                ? const CircularProgressIndicator(color: Colors.brown)
                :  Text(logingo,style: TextStyle(color: Colors.black),), fill: true),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.white,
        //     foregroundColor: const Color(0xFF4B1E00),
        //     padding:
        //     const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        //   ),
        //   onPressed: _isLoading ? null : submitData,
        //   child: _isLoading
        //       ? const CircularProgressIndicator(color: Colors.brown)
        //       : const Text("Create Account"),
        // ),

      ],
    );
  }
}
