import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';

class StaffManageOrderPage extends StatefulWidget {
  final String pageName;
  StaffManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _StaffManageOrderPageState();
}

class _StaffManageOrderPageState extends State<StaffManageOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mC,
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return OrderCard();
        },
      ),
    );
  }
}
