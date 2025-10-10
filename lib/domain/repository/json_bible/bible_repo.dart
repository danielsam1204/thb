import 'package:flutter/services.dart';
import 'package:thb/domain/models/bible_json_model.dart';

class BibleRepository {
  static Future<Map<String, BibleTamil>> loadBible() async {
    final jsonString = await rootBundle.loadString(
      'assets/bible_json/tamil_bible_json.json',
    );
    return bibleTamilFromJson(jsonString); // returns Map<String, BibleTamil>
  }
}
