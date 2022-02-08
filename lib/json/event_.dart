// To parse this JSON data, do
//
//     final newEvent = newEventFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

class NewEvent {
  NewEvent({
    required this.eventName,
    @required this.eventImage,
    required this.eventType,
    required this.eventId,
    required this.eventBuilding,
    required this.buildingType,
    required this.place,
    required this.date,
    required this.year,
    required this.time,
    required this.period,
    required this.details,
    required this.participants,
    required this.createUserUid,
    required this.isPublished,
    // required this.eventPickDate,
    required this.eventPickTime,
    // required this.lastDate,
    required this.lastTime,
    required this.lastDateTime,
    required this.eventDateTime,
  });

  final String eventName;
  final String? eventImage;
  final String eventType;
  final String eventId;
  final String eventBuilding;
  final String buildingType;
  final String place;
  final String date;
  final String year;
  final String time;
  final String period;
  final String details;
  final String eventPickTime;
  final List<String> participants;
  final String createUserUid;
  final bool isPublished;
  final String lastTime;
  final DateTime eventDateTime;
  final DateTime lastDateTime;

  factory NewEvent.fromJson(String str) => NewEvent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewEvent.fromMap(Map<String, dynamic> json) => NewEvent(
        eventName: json["event_name"],
        eventImage: json["event_image"],
        eventType: json["event_type"],
        eventId: json["eventId"],
        eventBuilding: json["eventBuilding"],
        buildingType: json["buildingType"],
        place: json["place"],
        date: json["date"],
        year: json["year"],
        time: json["time"],
        period: json["period"],
        details: json["details"],
        participants: List<String>.from(json["participants"].map((x) => x)),
        createUserUid: json["create_user_uid"],
        isPublished: json["isPublished"],
        eventPickTime: json["eventPickTime"],
        lastTime: json["lastTime"],
        eventDateTime: DateTime.parse(json["eventDateTime"]),
        lastDateTime: DateTime.parse(json["lastDateTime"]),
      );

  Map<String, dynamic> toMap() => {
        "event_name": eventName,
        "event_image": eventImage,
        "event_type": eventType,
        "eventId": eventId,
        "eventBuilding": eventBuilding,
        "buildingType": buildingType,
        "place": place,
        "date": date,
        "year": year,
        "time": time,
        "period": period,
        "details": details,
        "participants": List<dynamic>.from(participants.map((x) => x)),
        "create_user_uid": createUserUid,
        "isPublished": isPublished,
        "eventPickTime": eventPickTime,
        "lastTime": lastTime,
        "eventDateTime": eventDateTime.toIso8601String(),
        "lastDateTime": lastDateTime.toIso8601String(),
      };
}
