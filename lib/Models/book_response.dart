// To parse this JSON data, do
//
//     final bookResponse = bookResponseFromJson(jsonString);

import 'dart:convert';

BookResponse bookResponseFromJson(String str) =>
    BookResponse.fromJson(json.decode(str));

String bookResponseToJson(BookResponse data) => json.encode(data.toJson());

class BookResponse {
  BookResponse({
    this.message,
    this.errors,
  });

  String message;
  Errors errors;

  factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        message: json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors == null ? null : errors.toJson(),
      };
}

class Errors {
  Errors({
    this.from,
    this.to,
  });

  List<String> from;
  List<String> to;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        from: List<String>.from(json["from"].map((x) => x)),
        to: List<String>.from(json["to"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "from": List<dynamic>.from(from.map((x) => x)),
        "to": List<dynamic>.from(to.map((x) => x)),
      };
}
