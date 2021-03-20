// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';
import 'property_data.dart';

List<WishlistModel> wishlistFromJson(String str) => List<WishlistModel>.from(
    json.decode(str).map((x) => WishlistModel.fromJson(x)));

String wishlistToJson(List<WishlistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistModel {
  WishlistModel({
    this.id,
    this.userId,
    this.propertyId,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.property,
  });

  int id;
  int userId;
  int propertyId;
  DateTime createdAt;
  DateTime updatedAt;
  String type;
  PropertyData property;

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json["id"],
        userId: json["user_id"],
        propertyId: json["property_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        property: PropertyData.fromJson(json["property"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "property_id": propertyId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type,
        "property": property.toJson(),
      };
}
