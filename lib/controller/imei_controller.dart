import 'package:flutter/cupertino.dart';

class ImeiController extends ChangeNotifier {
  bool permission = false;

  refreshScreen() {
    if (permission == false) {
      permission = true;
      notifyListeners();
      print(refreshScreen());
    }
  }
}
