// To parse this JSON data, do
//
//     final usersInfo = usersInfoFromMap(jsonString);

import 'dart:convert';

class UsersInfo {
  UsersInfo({
    required this.name,
    required this.uid,
    required this.email,
    required this.password,
    required this.photo,
    required this.dateOfBirth,
    required this.phoneNo,
    required this.address,
    required this.registeredEvents,
    required this.colorNumber,
    required this.followersList,
    required this.followingList,
    required this.publishedEvent,
    required this.unPublishedEvent,
  });

  final String name;
  final String uid;
  final String password;
  final String email;
  final String photo;
  final String dateOfBirth;
  final String phoneNo;
  final String address;
  final int colorNumber;
  final List<String> registeredEvents;
  final List<String> followersList;
  final List<String> followingList;
  final List<String> publishedEvent;
  final List<String> unPublishedEvent;

  factory UsersInfo.fromJson(String str) => UsersInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersInfo.fromMap(Map<String, dynamic> json) => UsersInfo(
        name: json["name"],
        uid: json["uid"],
        email: json["email"],
        password: json["password"],
        dateOfBirth: json["dateOfBirth"],
        photo: json["photo"],
        phoneNo: json["phone no"],
        address: json["address"],
        colorNumber: json["colorNumber"],
        registeredEvents:
            List<String>.from(json["registeredEvents"].map((x) => x)),
        followersList: List<String>.from(json["followersList"].map((x) => x)),
        followingList: List<String>.from(json["followingList"].map((x) => x)),
        publishedEvent: List<String>.from(json["publishedEvent"].map((x) => x)),
        unPublishedEvent:
            List<String>.from(json["unPublishedEvent"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "uid": uid,
        "email": email,
        "password": password,
        "dateOfBirth": dateOfBirth,
        "photo": photo,
        "phone no": phoneNo,
        "address": address,
        "colorNumber": colorNumber,
        "registeredEvents": List<String>.from(registeredEvents.map((x) => x)),
        "followersList": List<String>.from(followersList.map((x) => x)),
        "followingList": List<String>.from(followingList.map((x) => x)),
        "publishedEvent": List<dynamic>.from(publishedEvent.map((x) => x)),
        "unPublishedEvent": List<dynamic>.from(unPublishedEvent.map((x) => x)),
      };
}
