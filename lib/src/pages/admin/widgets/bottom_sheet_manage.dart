import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/admin/controllers/admin_controller.dart';

class BottomSheetManage extends StatefulWidget {
  final List<String> values;
  final bool isMerchant;
  final String idObject;
  BottomSheetManage({this.values, this.isMerchant, this.idObject});
  @override
  State<StatefulWidget> createState() => _BottomSheetManageState();
}

class _BottomSheetManageState extends State<BottomSheetManage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: mCD,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            _buildAction(
              context,
              widget.values[0],
              widget.values.length == 1 ? colorHigh : colorPrimary,
              widget.values.length == 1
                  ? Feather.x_square
                  : Feather.check_square,
            ),
            widget.values.length == 2
                ? Column(
                    children: [
                      SizedBox(height: 16.0),
                      _buildAction(
                        context,
                        widget.values[1],
                        colorHigh,
                        Feather.x_square,
                      ),
                      SizedBox(height: 24.0),
                    ],
                  )
                : SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, color, icon) {
    final _size = MediaQuery.of(context).size;
    final adminController = Get.put(AdminController());

    return GestureDetector(
      onTap: () {
        Get.back();
        if (widget.isMerchant) {
          if (title == widget.values[0] && widget.values.length == 1) {
            adminController.cancelMerchant(widget.idObject);
          } else if (title == widget.values[0] && widget.values.length == 2) {
            adminController.approveMerchant(widget.idObject);
          } else {
            adminController.rejectMerchant(widget.idObject);
          }
        } else {
          if (title == widget.values[0] && widget.values.length == 1) {
            adminController.cancelTransport(widget.idObject);
          } else if (title == widget.values[0] && widget.values.length == 2) {
            adminController.approveTransport(widget.idObject);
          } else {
            adminController.rejectTransport(widget.idObject);
          }
        }
      },
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(28.0, 10.0, 20.0, 10.0),
        child: Row(
          children: [
            Icon(icon, size: width / 20.0, color: color),
            SizedBox(width: 10.0),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: _size.width / 22.5,
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
