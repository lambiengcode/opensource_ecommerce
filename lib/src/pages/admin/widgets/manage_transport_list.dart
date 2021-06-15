import 'package:get/get.dart';
import 'package:van_transport/src/pages/admin/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:van_transport/src/pages/admin/widgets/bottom_sheet_manage.dart';
import 'package:van_transport/src/pages/transport/widgets/vertical_transport_card.dart';

class ManageTransportList extends StatefulWidget {
  final pageName;
  ManageTransportList({@required this.pageName});
  @override
  State<StatefulWidget> createState() => _ManageTransportListState();
}

class _ManageTransportListState extends State<ManageTransportList> {
  final adminController = Get.put(AdminController());
  List<String> actives = ['Kết thúc hợp đồng'];
  List<String> inactives = ['Đồng ý hợp tác', 'Huỷ yêu cầu hợp tác'];

  void showManageBottomSheet(id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSheetManage(
          idObject: id,
          isMerchant: false,
          values: widget.pageName == 'ACTIVE' ? actives : inactives,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    adminController.getTransport(widget.pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: StreamBuilder(
          stream: adminController.getTransportStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () =>
                      showManageBottomSheet(snapshot.data[index]['_id']),
                  onTap: () =>
                      showManageBottomSheet(snapshot.data[index]['_id']),
                  child: VerticalTransportCard(
                    isCover: false,
                    image: null,
                    address: snapshot.data[index]['headquarters'],
                    title: snapshot.data[index]['name'],
                    urlToImage: snapshot.data[index]['avatar'],
                    desc: snapshot.data[index]['description'],
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
