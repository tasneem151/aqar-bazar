import 'package:aqar_bazar/screens/sign_up.dart';
import 'package:aqar_bazar/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate,],
      supportedLocales: [const Locale('en', 'US'),],
      debugShowCheckedModeBanner: false,
      theme: Themes.themeData(context),
      home: SignUp(),
    );
  }
}
