import 'package:flutter/material.dart';

class Themes {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      primaryColor: Color(0xff015ca7),
      accentColor: Color(0xff21d8a2),
      scaffoldBackgroundColor: Color(0xfff6f6f6),
      iconTheme: IconThemeData(
        color: Color(0xff21d8a2),
      ),
    );
  }
}
