import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';

class WaitForConfirmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WaitForConfirmPageState();
}

class _WaitForConfirmPageState extends State<WaitForConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return OrderCard();
        },
      ),
    );
  }
}
