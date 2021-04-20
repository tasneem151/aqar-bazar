import 'dart:convert';

import 'dart:math';

Agent agentInfoFromJson(String str) => Agent.fromJson(json.decode(str));

String agentInfoToJson(Agent data) => json.encode(data.toJson());

class Agent {
  Agent({
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
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        firstName:
            json["first_name"] == null ? 'Agent Not Found' : json["first_name"],
        lastName: json["last_name"] == null ? ' ' : json["last_name"],
        email: json["email"] == null ? 'Email Not Found' : json["email"],
        phone: json["phone"] == null ? 'Phone Not Found' : json["phone"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName == null ? 'Agent Not Found' : firstName,
        "last_name": lastName == null ? ' ' : lastName,
        "email": email == null ? 'Email Not Found' : email,
        "phone": phone == null ? 'Phone Not Found' : phone,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
