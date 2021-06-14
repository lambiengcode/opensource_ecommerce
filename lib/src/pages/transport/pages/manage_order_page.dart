import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/profile/widgets/bottom_settings_address.dart';
import 'package:van_transport/src/pages/sub_transport/widgets/sub_city_card.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/services/string_service.dart';

class TransportManageOrderPage extends StatefulWidget {
  final String pageName;
  final String idUser;
  TransportManageOrderPage({this.pageName, this.idUser});
  @override
  State<StatefulWidget> createState() => _TransportManageOrderPageState();
}

class _TransportManageOrderPageState extends State<TransportManageOrderPage> {
  final transportController = Get.put(TransportController());
  List<String> values = ['Delete Sub Transport'];

  @override
  void initState() {
    super.initState();
    if (widget.idUser != null) {
      transportController.getAllSubTransportByStatus('INACTIVE');
    } else {
      transportController.getAllSubTransportByStatus('ACTIVE');
    }
  }

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
      child: StreamBuilder(
        stream: transportController.getSubTransportStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  if (widget.idUser != null) {
                  } else {
                    showGroupProductSettings(index.toString());
                  }
                },
                onTap: () {
                  if (widget.idUser != null) {
                    transportController.assignStaff(
                      snapshot.data[index]['_id'],
                      widget.idUser,
                    );
                  }
                },
                child: SubCityCard(
                  fullName: StringService()
                      .formatString(25, snapshot.data[index]['name']),
                  manager: '0989917877',
                  address: StringService().formatString(
                    20,
                    snapshot.data[index]['location']['address'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
