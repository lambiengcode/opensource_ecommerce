import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/empty/empty_order_page.dart';
import 'package:van_transport/src/pages/order/controllers/order_controller.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/string_service.dart';

class ManageOrderPage extends StatefulWidget {
  final String pageName;
  ManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _ManageOrderPageState();
}

class _ManageOrderPageState extends State<ManageOrderPage> {
  final orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.getOrder(widget.pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: StreamBuilder(
        stream: orderController.getCartController,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return snapshot.data.length == 0
              ? EmptyOrderPage()
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.DETAILSORDERS,
                        arguments: {
                          'data': snapshot.data[index],
                          'comeFrom': 'USER',
                        },
                      ),
                      child: OrderCard(
                        title: StringService().formatString(
                          25,
                          snapshot.data[index]['isMerchantSend'] == true
                              ? snapshot.data[index]['FK_Product'][0]
                                  ['products'][0]['name']
                              : snapshot.data[index]['FK_Product'][0]['name'],
                        ),
                        transport: StringService().formatPrice(
                                double.tryParse(snapshot.data[index]['prices'])
                                    .round()
                                    .toString()) +
                            ' đ',
                        urlToImage: snapshot.data[index]['isMerchantSend'] ==
                                true
                            ? snapshot.data[index]['FK_Product'][0]['products']
                                    [0]['image']
                                .toString()
                                .trim()
                            : snapshot.data[index]['FK_Product'][0]['image'][0]
                                .toString()
                                .trim(),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
