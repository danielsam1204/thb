import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/screens/homepage.dart';
import 'package:thb/screens/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Scale Animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoController.forward();

    // Text Slide + Fade Animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // Start text animation after logo
    Future.delayed(const Duration(seconds: 1), () {
      _textController.forward();
    });
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? landingEnabled = prefs.getBool("landing");

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // landingEnabled == true ? const HomePage() :
              const LandingPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _logoScaleAnimation,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/image/logo.png", height: 120),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
