import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';

class StaffWaitForConfirmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaffWaitForConfirmPageState();
}

class _StaffWaitForConfirmPageState extends State<StaffWaitForConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mC,
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return OrderCard();
        },
      ),
    );
  }
}
