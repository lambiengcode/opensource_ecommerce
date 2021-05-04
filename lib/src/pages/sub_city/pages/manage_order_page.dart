import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';

class SubCityManageOrderPage extends StatefulWidget {
  final String pageName;
  SubCityManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _SubCityManageOrderPageState();
}

class _SubCityManageOrderPageState extends State<SubCityManageOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return SubCityCard(
            fullName: 'Phường 14',
            manager: 'Đào Hồng Vinh',
            address: 'Phường 14, Quận 1',
          );
        },
      ),
    );
  }
}
