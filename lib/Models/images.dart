class PropertyImage {
  PropertyImage({
    this.id,
    this.propertyId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int propertyId;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
        id: json["id"],
        propertyId: json["property_id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
