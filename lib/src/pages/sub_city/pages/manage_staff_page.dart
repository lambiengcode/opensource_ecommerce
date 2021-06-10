import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/sub_city/widgets/user_card.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';

class ManageStaffPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageStaffPageState();
}

class _ManageStaffPageState extends State<ManageStaffPage> {
  final transportController = Get.put(TransportController());

  @override
  void initState() {
    super.initState();
    transportController.getAssignTransport();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mC,
      padding: EdgeInsets.only(top: 12.0),
      child: StreamBuilder(
        stream: transportController.getAssignStaffStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          print(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return UserCard(
                fullName: snapshot.data[index]['fullName'],
                phone: snapshot.data[index]['email'],
                address: snapshot.data[index]['address'].length == 0
                    ? 'Unknown'
                    : snapshot.data[index]['address'][0]['fullName'],
                image: snapshot.data[index]['image'],
              );
            },
          );
        },
      ),
    );
  }
}
