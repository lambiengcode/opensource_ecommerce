import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/pages/transport/pages/manage_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ChooseSubTransportPage extends StatefulWidget {
  final String idUser;
  ChooseSubTransportPage({this.idUser});
  @override
  State<StatefulWidget> createState() => _ChooseSubTransportState();
}

class _ChooseSubTransportState extends State<ChooseSubTransportPage>
    with SingleTickerProviderStateMixin {
  final transportController = Get.put(TransportController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    transportController.getTransport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: 1.5,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 15.0,
          ),
        ),
        title: Text(
          'Chọn cơ sở quản lí',
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: TransportManageOrderPage(
        pageName: '',
        idUser: widget.idUser,
      ),
    );
  }
}
