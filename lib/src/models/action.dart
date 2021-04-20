import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Action {
  final String title;
  final IconData icon;

  Action({this.icon, this.title});
}

List<Action> actions = [
  new Action(title: 'All', icon: FontAwesomeIcons.fireAlt),
  new Action(title: 'Fast', icon: FontAwesomeIcons.truck),
  new Action(title: 'Food', icon: FontAwesomeIcons.pizzaSlice),
  new Action(title: 'Cold', icon: FontAwesomeIcons.snowflake),
  new Action(title: 'Globe', icon: FontAwesomeIcons.globe),
];
