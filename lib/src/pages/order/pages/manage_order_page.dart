import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';

class ManageOrderPage extends StatefulWidget {
  final String pageName;
  ManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _ManageOrderPageState();
}

class _ManageOrderPageState extends State<ManageOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.DETAILSORDERS),
            child: OrderCard(),
          );
        },
      ),
    );
  }
}
