import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';

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
          return SubCityCard(
            fullName: 'Hồ Chí Minh',
            address: 'Hồ Chí Minh, Việt Nam',
            manager: 'Đào Hồng Vinh',
          );
        },
      ),
    );
  }
}
