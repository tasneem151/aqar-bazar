import 'package:aqar_bazar/Models/profile_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelsProvider extends ChangeNotifier {
  bool internetAccess = true;
  String token;
  ProfileInfo user;

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

  ProfileInfo getUserInfo() {
    return user;
  }

  /* void setLocale(String lang) {
    langCode = lang;
    notifyListeners();
  }

  String getLocale() {
    return langCode;
  } */
}
