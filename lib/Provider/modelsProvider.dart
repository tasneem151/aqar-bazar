import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ModelsProvider extends ChangeNotifier {
  bool internetAccess = true;
  String token;
  ProfileInfo user;
  String countryCode;

  void setInternetAccess(bool status) {
    internetAccess = status;
    notifyListeners();
  }

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  void setUserInfo(ProfileInfo newUser) {
    user = newUser;
    notifyListeners();
  }

  void setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }
}
