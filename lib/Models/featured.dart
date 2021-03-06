class Featured {
  Featured({
    this.id,
    this.ownerId,
    this.agentId,
    this.compoundId,
    this.categoryId,
    this.active,
    this.mainImageUrl,
    this.approved,
    this.rent,
    this.purchase,
    this.rentPrice,
    this.purchasePrice,
    this.area,
    this.payCycle,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.featured,
    this.title,
    this.description,
    this.location,
  });

  int id;
  int ownerId;
  dynamic agentId;
  dynamic compoundId;
  int categoryId;
  int active;
  MainImageUrl mainImageUrl;
  int approved;
  int rent;
  int purchase;
  String rentPrice;
  String purchasePrice;
  int area;
  String payCycle;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int featured;
  String title;
  String description;
  String location;

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
        id: json["id"],
        ownerId: json["owner_id"],
        agentId: json["agent_id"],
        compoundId: json["compound_id"],
        categoryId: json["category_id"],
        active: json["active"],
        mainImageUrl: mainImageUrlValues.map[json["main_image_url"]],
        approved: json["approved"],
        rent: json["rent"],
        purchase: json["purchase"],
        rentPrice: json["rent_price"],
        purchasePrice: json["purchase_price"],
        area: json["area"],
        payCycle: json["pay_cycle"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        featured: json["featured"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "agent_id": agentId,
        "compound_id": compoundId,
        "category_id": categoryId,
        "active": active,
        "main_image_url": mainImageUrlValues.reverse[mainImageUrl],
        "approved": approved,
        "rent": rent,
        "purchase": purchase,
        "rent_price": rentPrice,
        "purchase_price": purchasePrice,
        "area": area,
        "pay_cycle": payCycle,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "featured": featured,
        "title": title,
        "description": description,
        "location": location,
      };
}

enum MainImageUrl { NO_IMAGE }

final mainImageUrlValues = EnumValues({"no_image": MainImageUrl.NO_IMAGE});

/* enum PayCycle { MONTH }

final payCycleValues = EnumValues({"month": PayCycle.MONTH}); */

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
