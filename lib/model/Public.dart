import 'package:flutter/foundation.dart';

class Public extends ChangeNotifier {
  int initPage = 0;

  void changeInitPage(int i) {
    initPage = i;
    notifyListeners();
  }
}
