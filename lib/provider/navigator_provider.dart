import 'package:flutter/material.dart';

class ChooseNavigation with ChangeNotifier {
  int _pilihIndex = 0;
  int get chooseIndex => _pilihIndex;

  void changeIndex(int index) {
    _pilihIndex = index;
    notifyListeners();
  }
}
