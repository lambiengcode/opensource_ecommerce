import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';

class StaffRejectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StaffRejectPageState();
}

class _StaffRejectPageState extends State<StaffRejectPage> {
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
