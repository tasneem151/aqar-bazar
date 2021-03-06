// To parse this JSON data, do
//
//     final forRent = forRentFromJson(jsonString);

import 'dart:convert';

import 'package:aqar_bazar/Models/featured.dart';

ForRent forRentFromJson(String str) => ForRent.fromJson(json.decode(str));

String forRentToJson(ForRent data) => json.encode(data.toJson());

class ForRent {
  ForRent({
    this.latest,
    this.featured,
  });

  List<Featured> latest;
  List<Featured> featured;

  factory ForRent.fromJson(Map<String, dynamic> json) => ForRent(
        latest: List<Featured>.from(
            json["latest"].map((x) => Featured.fromJson(x))),
        featured: List<Featured>.from(
            json["featured"].map((x) => Featured.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "latest": List<dynamic>.from(latest.map((x) => x.toJson())),
        "featured": List<dynamic>.from(featured.map((x) => x.toJson())),
      };
}
