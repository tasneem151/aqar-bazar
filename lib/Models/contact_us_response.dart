// To parse this JSON data, do
//
//     final contactUsResponse = contactUsResponseFromJson(jsonString);

import 'dart:convert';

ContactUsResponse contactUsResponseFromJson(String str) =>
    ContactUsResponse.fromJson(json.decode(str));

String contactUsResponseToJson(ContactUsResponse data) =>
    json.encode(data.toJson());

class ContactUsResponse {
  ContactUsResponse({
    this.message,
  });

  String message;

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      ContactUsResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
