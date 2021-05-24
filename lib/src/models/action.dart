import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Action {
  final String title;
  final IconData icon;

  Action({
    @required this.title,
    @required this.icon,
  });

  Action copyWith({
    String title,
    IconData icon,
  }) {
    return Action(
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon.codePoint,
    };
  }

  factory Action.fromMap(Map<String, dynamic> map) {
    return Action(
      title: map['title'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Action.fromJson(String source) => Action.fromMap(json.decode(source));

  @override
  String toString() => 'Action(title: $title, icon: $icon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Action && other.title == title && other.icon == icon;
  }

  @override
  int get hashCode => title.hashCode ^ icon.hashCode;
}

List<Action> actions = [
  new Action(title: 'All', icon: FontAwesomeIcons.fireAlt),
  new Action(title: 'Fast', icon: FontAwesomeIcons.truck),
  new Action(title: 'Food', icon: FontAwesomeIcons.pizzaSlice),
  new Action(title: 'Cold', icon: FontAwesomeIcons.snowflake),
  new Action(title: 'Globe', icon: FontAwesomeIcons.globe),
];
