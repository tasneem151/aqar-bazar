import 'dart:io';

import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:aqar_bazar/size_config.dart';
import 'package:aqar_bazar/localization/app_localization.dart';

class Manager {
  static Future<void> setAuthToken(String authToken, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', authToken);
    Provider.of<ModelsProvider>(context, listen: false).setToken(authToken);
  }

  static Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken = pref.getString('token') ?? '';
    return authToken;
  }

  /* static Future<void> setLang(String lang, context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('lang', lang);
    Provider.of<ModelsProvider>(context, listen: false).setLocale(lang);
  }

  static Future<String> getLang() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String lang = pref.getString('lang') ?? 'en';
    return lang;
  } */

  /* static Future<void> setUserInfo(ProfileInfo user, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('first name', user.firstName);
    //Provider.of<ModelsProvider>(context, listen: false).setUserInfo(newUser)
    prefs.setString('last name', user.lastName);
    prefs.setString('email', user.email);
    prefs.setString('phone', user.phone);
  } */

  static Future<bool> logout(BuildContext context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', '');
    Provider.of<ModelsProvider>(context, listen: false).setToken('');
    return true;
  }

  static Future<bool> checkInternet(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Provider.of<ModelsProvider>(context, listen: false)
              .setInternetAccess(true);
        }
      } on SocketException catch (_) {
        Provider.of<ModelsProvider>(context, listen: false)
            .setInternetAccess(false);
        return false;
      }

      return true;
    } else {
      Provider.of<ModelsProvider>(context, listen: false)
          .setInternetAccess(false);
    }

    return false;
  }

  static void noConnectionAlert(BuildContext context) {
    AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.NO_HEADER,
        body: Center(
            child: Column(
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
              color: Color(0xff21d8a2),
            ),
            Text("No Internet Access")
          ],
        )),
        title: "No Internet Access",
        desc: "Please Connect to internet and try again",
        autoHide: Duration(seconds: 2))
      ..show();
  }

  static void toastMessage(String message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        textColor: Colors.red,
        backgroundColor: color,
        fontSize: 16.0);
  }

  static void alertDialog(String title, String content, BuildContext context) {
    SizeConfig().init(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(right: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text(content,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).accentColor)),
          actions: <Widget>[
            Container(
                height: SizeConfig.safeBlockVertical * 6,
                width: SizeConfig.safeBlockHorizontal * 75,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          Text(Applocalizations.of(context).translate("Close")),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  )),
                ]))
          ],
        );
      },
    );
  }
}
