import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/sub_city/widgets/user_card.dart';

class ManageStaffPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageStaffPageState();
}

class _ManageStaffPageState extends State<ManageStaffPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mC,
      padding: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return UserCard(
            fullName: 'Dao Hong Vinh',
            phone: '0989917877',
            address: '56 Tan Long, Tan Dong Hiep',
            image: 'https://avatars.githubusercontent.com/u/60530946?v=4',
          );
        },
      ),
    );
  }
}
