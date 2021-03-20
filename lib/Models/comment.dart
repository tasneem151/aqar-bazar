import 'client.dart';

class Comment {
  Comment({
    this.id,
    this.clientId,
    this.propertyId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.client,
  });

  int id;
  int clientId;
  int propertyId;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  Client client;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        clientId: json["client_id"],
        propertyId: json["property_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        client: Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "property_id": propertyId,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "client": client.toJson(),
      };
}
