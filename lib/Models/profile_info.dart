// To parse this JSON data, do
//
//     final profileInfo = profileInfoFromJson(jsonString);

import 'dart:convert';

ProfileInfo profileInfoFromJson(String str) =>
    ProfileInfo.fromJson(json.decode(str));

String profileInfoToJson(ProfileInfo data) => json.encode(data.toJson());

class ProfileInfo {
  ProfileInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
