// To parse this JSON data, do
//
//     final getComments = getCommentsFromJson(jsonString);

import 'dart:convert';
import 'comment.dart';

List<Comment> getCommentsFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String getCommentsToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
