import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/empty/empty_order_page.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';
import 'package:van_transport/src/pages/sub_transport/controllers/sub_transport_controller.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/string_service.dart';

class SubTransportManageOrderPage extends StatefulWidget {
  final String pageName;
  SubTransportManageOrderPage({this.pageName});
  @override
  State<StatefulWidget> createState() => _SubTransportManageOrderPageState();
}

class _SubTransportManageOrderPageState
    extends State<SubTransportManageOrderPage> {
  final orderController = Get.put(SubTransportController());

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
                          'comeFrom': 'TRANSPORT',
                          'pageName': widget.pageName,
                        },
                      ),
                      child: OrderCard(
                        title: StringService().formatString(
                          25,
                          snapshot.data[index]['isMerchantSend'] == true
                              ? snapshot.data[index]['FK_Product'][0]
                                  ['products'][0]['name']
                              : snapshot.data[0]['FK_Product'][0]['name'],
                        ),
                        transport: StringService().formatPrice(
                                double.tryParse(snapshot.data[index]['prices'])
                                    .round()
                                    .toString()) +
                            ' đ',
                        urlToImage:
                            snapshot.data[index]['isMerchantSend'] == true
                                ? snapshot.data[index]['FK_Product'][0]
                                    ['products'][0]['image']
                                : snapshot.data[0]['FK_Product'][0]['image'][0],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
