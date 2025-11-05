import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController implements GetxService {
  final TextEditingController searchController = TextEditingController();
  int _searchLetterIndex = -1;
  final List<String> _tamilLetters = [
    "அ",
    "ஆ",
    "இ",
    "ஈ",
    "உ",
    "ஊ",
    "எ",
    "ஏ",
    "ஐ",
    "ஒ",
    "ஓ",
    "ஔ",
  ];

  List<String> get tamilLetters => _tamilLetters;

  int get searchLetterIndex => _searchLetterIndex;

  void onSelectLetter(int index) {
    _searchLetterIndex = index;
    searchController.text = tamilLetters[index];
    update();
  }

  void onTapClearSearch() {
    searchController.clear();
    _searchLetterIndex = -1;
    update();
  }

  void initCall(){
    onSelectLetter(0);
  }
}
