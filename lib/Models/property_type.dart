// To parse this JSON data, do
//
//     final propertyType = propertyTypeFromJson(jsonString);

import 'dart:convert';

List<PropertyType> propertyTypeFromJson(String str) => List<PropertyType>.from(
    json.decode(str).map((x) => PropertyType.fromJson(x)));

String propertyTypeToJson(List<PropertyType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyType {
  PropertyType({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.title,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String title;

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        title: json["title"] == null ? 'Unknown' : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
        "title": title == null ? 'Unknown' : title,
      };
}
