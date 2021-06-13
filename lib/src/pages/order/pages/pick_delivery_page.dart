import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/widgets/order_card.dart';
import 'package:van_transport/src/services/string_service.dart';

class PickDeliveryPage extends StatefulWidget {
  final String idMerchant;
  PickDeliveryPage({this.idMerchant});
  @override
  State<StatefulWidget> createState() => _PickDeliveryPageState();
}

class _PickDeliveryPageState extends State<PickDeliveryPage>
    with SingleTickerProviderStateMixin {
  final pickAddressController = Get.put(PickAddressController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pickAddressController.getListTransport(widget.idMerchant);
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
          'Chọn nhà vận chuyển',
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: pickAddressController.getListTransportController,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return ListView.builder(
              itemCount: snapshot.data['transport'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pickAddressController.pickDelivery(
                        snapshot.data['sender'],
                        snapshot.data['receiver'],
                        snapshot.data['transport'][index]);
                    Get.back();
                  },
                  child: OrderCard(
                    title: snapshot.data['transport'][index]['FK_Transport']
                        ['name'],
                    subTitle: StringService().formatPrice(double.tryParse(
                            snapshot.data['transport'][index]['price'])
                        .round()
                        .toString()),
                    urlToImage: snapshot.data['transport'][index]
                        ['FK_Transport']['avatar'],
                    transport: snapshot.data['transport'][index]['FK_Transport']
                        ['name'],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
