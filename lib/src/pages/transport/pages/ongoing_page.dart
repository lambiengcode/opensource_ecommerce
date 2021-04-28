import 'package:flutter/material.dart';

class OngoingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
