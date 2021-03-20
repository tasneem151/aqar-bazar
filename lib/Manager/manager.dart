import 'dart:io';

import 'package:aqar_bazar/Provider/modelsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Manager {
  static Future<void> setAuthToken(String authToken, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', authToken);
    Provider.of<ModelsProvider>(context, listen: false).setToken(authToken);
  }

  static Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken = pref.getString('token') ?? null;
    return authToken;
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
}
