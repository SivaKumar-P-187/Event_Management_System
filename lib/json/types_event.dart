// To parse this JSON data, do
//
//     final typeEvent = typeEventFromMap(jsonString);

import 'dart:convert';
import 'package:emojis/emojis.dart';
import 'package:emojis/emoji.dart';

class TypeEvent {
  TypeEvent({
    required this.name,
    required this.eventIcon,
  });

  final String name;
  final String eventIcon;

  factory TypeEvent.fromJson(String str) => TypeEvent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeEvent.fromMap(Map<String, dynamic> json) => TypeEvent(
        name: json["name"],
        eventIcon: json["event_icon"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "event_icon": eventIcon,
      };
}

class InitializeEvent {
  static get initUsers => <TypeEvent>[
        TypeEvent(
          name: "All Event",
          eventIcon:
              Emoji.stabilize(Emojis.partyPopper, skin: false, gender: true),
        ),
        TypeEvent(
          name: "Birthday",
          eventIcon:
              Emoji.stabilize(Emojis.partyingFace, skin: false, gender: true),
        ),
        TypeEvent(
          name: "Anniversary",
          eventIcon: Emoji.stabilize(Emojis.womanAndManHoldingHands,
              skin: false, gender: true),
        ),
      ];
}
