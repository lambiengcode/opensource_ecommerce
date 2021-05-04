import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';

class TransportManageOrderPage extends StatefulWidget {
  final String pageName;
  TransportManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _TransportManageOrderPageState();
}

class _TransportManageOrderPageState extends State<TransportManageOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return SubCityCard(
            fullName: 'Hồ Chí Minh',
            manager: 'Đào Hồng Vinh',
            address: 'Hồ Chí Minh, Việt Nam',
          );
        },
      ),
    );
  }
}
