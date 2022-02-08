// To parse this JSON data, do
//
//     final notification = notificationFromMap(jsonString);

import 'dart:convert';

class NotificationJson {
  NotificationJson({
    required this.username,
    required this.userId,
    required this.event,
    required this.dateTime,
    required this.notificationId,
    required this.eventName,
  });

  final String username;
  final String userId;
  final String event;
  final DateTime dateTime;
  final String notificationId;
  final String eventName;

  factory NotificationJson.fromJson(String str) =>
      NotificationJson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationJson.fromMap(Map<String, dynamic> json) =>
      NotificationJson(
        username: json["username"],
        userId: json["userId"],
        event: json["event"],
        dateTime: DateTime.parse(json["dateTime"]),
        notificationId: json["notificationId"],
        eventName: json["eventName"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "userId": userId,
        "event": event,
        "dateTime": dateTime.toIso8601String(),
        "notificationId": notificationId,
        "eventName": eventName,
      };
}
