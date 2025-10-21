import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/widgets/time_picker.dart';

class HomeController extends GetxController implements GetxService {
  bool _isToggle = false;
  String? _selectTime;

  bool get isToggle => _isToggle;

  String? get selectTime => _selectTime;

  void onChangeSwitch(bool? val) {
    _isToggle = val!;
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
}
