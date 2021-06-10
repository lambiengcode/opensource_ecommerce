import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/profile/widgets/bottom_settings_address.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';

class TransportManageOrderPage extends StatefulWidget {
  final String pageName;
  TransportManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _TransportManageOrderPageState();
}

class _TransportManageOrderPageState extends State<TransportManageOrderPage> {
  List<String> values = ['Delete Sub Transport'];

  showGroupProductSettings(id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSettingsAddress(
          values: values,
          idMerchant: id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => showGroupProductSettings(index),
            child: SubCityCard(
              fullName: 'Hồ Chí Minh',
              manager: 'Đào Hồng Vinh',
              address: 'Hồ Chí Minh, Việt Nam',
            ),
          );
        },
      ),
    );
  }
}
