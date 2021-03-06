import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ModelsProvider extends ChangeNotifier {
  bool internetAccess = true;
  String token;

  void setInternetAccess(bool status) {
    internetAccess = status;
    notifyListeners();
  }

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }
}
