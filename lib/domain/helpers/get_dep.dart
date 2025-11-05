import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/controllers/dashboard_controller.dart';
import 'package:thb/controllers/dictionary_controller.dart';
import 'package:thb/controllers/home_controller.dart';
import 'package:thb/controllers/map_controller.dart';
import 'package:thb/controllers/prayer_controller.dart';
import 'package:thb/controllers/profile_controller.dart';
import 'package:thb/controllers/settings_controller.dart';

Future<void> init() async {
  // sharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences, permanent: true);
  // Controller
  Get.lazyPut(() => DashboardController(sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => SettingsController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => MapController(sharedPreferences: Get.find()));
  Get.lazyPut(() => PrayerController());
  Get.lazyPut(() => DictionaryController());
}
