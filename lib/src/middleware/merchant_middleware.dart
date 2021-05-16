import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';
import 'package:van_transport/src/pages/merchant/merchant_page.dart';
import 'package:van_transport/src/pages/merchant/pages/register_merchant_page.dart';
import 'package:van_transport/src/widgets/loading_page.dart';

class MerchantMiddleware extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MerchantMiddlewareState();
}

class _MerchantMiddlewareState extends State<MerchantMiddleware> {
  final merchantController = Get.put(MerchantController());

  @override
  void initState() {
    super.initState();
    merchantController.getMerchant();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: merchantController.getMerchantStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        var mMerchant = snapshot.data;

        return mMerchant['status'] == 200
            ? MerchantPage(merchantInfo: mMerchant)
            : RegisterMerchantPage();
      },
    );
  }
}
