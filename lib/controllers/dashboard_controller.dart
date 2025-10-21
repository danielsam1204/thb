import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/screens/bible/bible_main_screen.dart';
import 'package:thb/widgets/custom_text.dart';
import 'package:thb/screens/dictionary/dictionary_screen.dart';
import 'package:thb/screens/home/home_screen.dart';
import 'package:thb/screens/prayer/prayer_screen.dart';
import 'package:thb/screens/q_and_a/q_and_a_screen.dart';
import 'package:thb/screens/read_bible/read_bible_screen.dart';

class DashboardController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  DashboardController({required this.sharedPreferences});

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    BiblePage(),
    DictionaryScreen(),
    PrayerScreen(),
    QAndAScreen(),
  ];

  List<Widget> get screens => _screens;

  int get currentIndex => _currentIndex;

  void onChangeIndex(int index) {
    _currentIndex = index;
    update();
  }
}
