// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<PropertyData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        currentPage: json["current_page"],
        data: List<PropertyData>.from(
            json["data"].map((x) => PropertyData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class PropertyData {
  PropertyData({
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
    this.props,
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
  Map<String, int> props;

  factory PropertyData.fromJson(Map<String, dynamic> json) => PropertyData(
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
        props:
            Map.from(json["props"]).map((k, v) => MapEntry<String, int>(k, v)),
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
        "props": Map.from(props).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

enum MainImageUrl { NO_IMAGE }

final mainImageUrlValues = EnumValues({"no_image": MainImageUrl.NO_IMAGE});

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  dynamic label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}

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
