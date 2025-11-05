import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:thb/screens/map/map_screen.dart';
import 'package:thb/widgets/bubble_page_route.dart';
import 'package:thb/widgets/custom_snackbar.dart';
import 'package:thb/widgets/time_picker.dart';

class HomeController extends GetxController implements GetxService {
  bool _isToggle = false;
  String? _selectTime;
  int _dailyPromiseTabIndex = 0;

  bool get isToggle => _isToggle;

  String? get selectTime => _selectTime;

  int get dailyPromiseTabIndex => _dailyPromiseTabIndex;

  void onChangeSwitch(bool? val) {
    _isToggle = val!;
    update();
  }

  void onChangeDailyPromiseTab(int? index) {
    _dailyPromiseTabIndex = index!;
    update();
  }

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await timePicker();
    if (pickedTime != null) {
      final formattedTime = TimeOfDay(
        hour: pickedTime.hour,
        minute: pickedTime.minute,
      ).format(Get.context!);
      _selectTime = formattedTime;
      update();
    }
  }

  initCall() {
    DateTime now = DateTime.now();
    _selectTime = TimeOfDay(
      hour: now.hour,
      minute: now.minute,
    ).format(Get.context!);
  }

  Future<void> onTapChurchContainer(TapDownDetails details) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showCustomSnackBar('Location permission denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showCustomSnackBar('Location permission permanently denied');
      return;
    }
    final tapPosition = details.globalPosition;
    Navigator.push(
      Get.context!,
      BubblePageRoute(
        position: tapPosition,
        builder: (context) => const MapScreen(),
      ),
    );
  }
}