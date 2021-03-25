import 'package:flutter/material.dart';

const kBoxShadow = BoxShadow(
  color: Colors.grey,
  offset: Offset(1.0, 4.0), //(x,y)
  blurRadius: 6.0,
);

const kButtonShadow = BoxShadow(
  color: Color(0xffBDBDBD),
  offset: Offset(1.0, 4.0), //(x,y)
  blurRadius: 6.0,
);

const kGradient = LinearGradient(
  colors: [
    Color(0xff21d8a2),
    Color(0xff015ca7),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.1, 1.0],
);

const kCustomBlueGrey = Color(0xff455A64);
String baseUrl = "http://new.aqarbazar.com";
