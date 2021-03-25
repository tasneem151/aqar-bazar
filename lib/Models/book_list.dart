// To parse this JSON data, do
//
//     final bookList = bookListFromJson(jsonString);

import 'dart:convert';
import 'property_data.dart';
import 'featured.dart';

List<BookedItemData> bookListFromJson(String str) => List<BookedItemData>.from(
    json.decode(str).map((x) => BookedItemData.fromJson(x)));

String bookListToJson(List<BookedItemData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookedItemData {
  BookedItemData({
    this.id,
    this.clientId,
    this.propertyId,
    this.from,
    this.to,
    this.rentPrice,
    this.payCycle,
    this.amount,
    this.status,
    this.stripeOrderId,
    this.createdAt,
    this.updatedAt,
    this.stripeSubscribeId,
    this.property,
  });

  int id;
  int clientId;
  int propertyId;
  DateTime from;
  DateTime to;
  int rentPrice;
  String payCycle;
  String amount;
  String status;
  dynamic stripeOrderId;
  DateTime createdAt;
  DateTime updatedAt;
  String stripeSubscribeId;
  Featured property;

  factory BookedItemData.fromJson(Map<String, dynamic> json) => BookedItemData(
        id: json["id"],
        clientId: json["client_id"],
        propertyId: json["property_id"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        rentPrice: json["rent_price"],
        payCycle: json["pay_cycle"],
        amount: json["amount"],
        status: json["status"],
        stripeOrderId: json["stripe_order_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        stripeSubscribeId: json["stripe_subscribe_id"] == null
            ? null
            : json["stripe_subscribe_id"],
        property: Featured.fromJson(json["property"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "property_id": propertyId,
        "from":
            "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
        "to":
            "${to.year.toString().padLeft(4, '0')}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}",
        "rent_price": rentPrice,
        "pay_cycle": payCycle,
        "amount": amount,
        "status": status,
        "stripe_order_id": stripeOrderId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "stripe_subscribe_id":
            stripeSubscribeId == null ? null : stripeSubscribeId,
        "property": property.toJson(),
      };
}
