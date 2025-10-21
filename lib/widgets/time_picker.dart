import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<TimeOfDay?> timePicker() async {
  return await showTimePicker(
    context: Get.context!,
    initialTime: TimeOfDay.now(),
  );
}
