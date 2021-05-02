import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';

class SubTransportRejectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubTransportRejectPageState();
}

class _SubTransportRejectPageState extends State<SubTransportRejectPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return SubCityCard(
            fullName: 'Quận 1',
            manager: 'Đào Hồng Vinh',
            address: 'Quận 1, Hồ Chí Minh',
          );
        },
      ),
    );
  }
}
