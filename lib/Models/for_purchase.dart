// To parse this JSON data, do
//
//     final forPurchase = forPurchaseFromJson(jsonString);

import 'dart:convert';

import 'package:aqar_bazar/Models/featured.dart';

ForPurchase forPurchaseFromJson(String str) =>
    ForPurchase.fromJson(json.decode(str));

String forPurchaseToJson(ForPurchase data) => json.encode(data.toJson());

class ForPurchase {
  ForPurchase({
    this.latest,
    this.featured,
  });

  List<Featured> latest;
  List<Featured> featured;

  factory ForPurchase.fromJson(Map<String, dynamic> json) => ForPurchase(
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
