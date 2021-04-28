import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';

class OngoingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return OrderCard();
        },
      ),
    );
  }
}
