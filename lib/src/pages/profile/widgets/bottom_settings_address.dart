import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/routes/app_pages.dart';

class BottomSettingsAddress extends StatefulWidget {
  final List<String> values;
  final String idAddress;
  final String idMerchant;
  final dataGroup;
  BottomSettingsAddress(
      {this.values, this.idAddress, this.idMerchant, this.dataGroup});
  @override
  State<StatefulWidget> createState() => _BottomSettingsAddressState();
}

class _BottomSettingsAddressState extends State<BottomSettingsAddress> {
  final profileController = Get.put(ProfileController());
  final merchantController = Get.put(MerchantController());
  final transportController = Get.put(TransportController());
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
              widget.values.length == 1 ? colorHigh : colorTitle,
              widget.values.length == 1 ? Feather.trash : Feather.edit,
            ),
            widget.values.length == 2
                ? Column(
                    children: [
                      SizedBox(height: 16.0),
                      _buildAction(
                        context,
                        widget.values[1],
                        colorHigh,
                        Feather.trash,
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

    return GestureDetector(
      onTap: () {
        Get.back();
        if (widget.values.length == 1) {
          if (widget.idAddress != null) {
            profileController.deleteAddress(widget.idAddress);
          } else {
            transportController.deleteSubTransport(widget.idMerchant);
          }
        } else {
          if (title == widget.values[0]) {
            Get.toNamed(Routes.MERCHANT + Routes.EDITGROUP,
                arguments: widget.dataGroup);
          } else {
            merchantController.deleteGroupProduct(
                widget.idAddress, widget.idMerchant);
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
