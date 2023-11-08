import 'dart:convert';

import 'package:intl/intl.dart';

class NotificationModel {
  final String? id;
  // final Data data;
  final String? img;
  final String? title;
  final String? body;
  final dynamic data;
  final DateTime? readAt;
  final DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.data,
    this.readAt,
    this.createdAt,
    this.img,
  });
  DateTime _parseDateTime(String dateTimeStr) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return dateFormat.parse(dateTimeStr);
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
  return  NotificationModel(
      img: map['image'],
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      data: map['data'],
      readAt: (String dateTimeStr) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a", "en");
        return dateFormat.parse(dateTimeStr);
      }(map['read_at'].toString()),
      createdAt: (String dateTimeStr) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a", "en");
        return dateFormat.parse(dateTimeStr);
      }(map['created_at'].toString()),
    );
  }

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
