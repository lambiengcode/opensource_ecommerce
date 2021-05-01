import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';

class SubTransportWaitForConfirmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubTransportWaitForConfirmPageState();
}

class _SubTransportWaitForConfirmPageState
    extends State<SubTransportWaitForConfirmPage> {
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
