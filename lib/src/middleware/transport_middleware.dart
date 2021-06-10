import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/pages/transport/pages/register_transport_page.dart';
import 'package:van_transport/src/pages/transport/transport_page.dart';
import 'package:van_transport/src/widgets/loading_page.dart';

class TransportMiddleware extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportMiddlewareState();
}

class _TransportMiddlewareState extends State<TransportMiddleware> {
  final transportController = Get.put(TransportController());

  @override
  void initState() {
    super.initState();
    transportController.getTransport();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: transportController.getTransportStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        var mMerchant = snapshot.data;
        return mMerchant['status'] == 200
            ? TransportPage()
            : RegisterTransportPage();
      },
    );
  }
}
