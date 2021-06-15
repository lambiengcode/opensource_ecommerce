import 'dart:ui';
import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';

class BottomSheetPayment extends StatefulWidget {
  final String typeOrders;
  final String point;
  BottomSheetPayment({this.typeOrders, this.point});
  @override
  State<StatefulWidget> createState() => _BottomSheetPaymentState();
}

class _BottomSheetPaymentState extends State<BottomSheetPayment> {
  final profileController = Get.put(ProfileController());
  final pickAddressController = Get.put(PickAddressController());
  String paymentMethod;
  List<String> methods = ['Point', 'Paypal', 'VNPAY'];

  @override
  void initState() {
    super.initState();
    paymentMethod = widget.typeOrders == BUY_POINT ? methods[1] : methods[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 44.0),
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: width * .3),
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
            SizedBox(height: 18.0),
            Text(
              'Chọn phuơng thức thanh toán',
              style: TextStyle(
                color: colorDarkGrey,
                fontSize: width / 22.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'Lato',
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                paymentMethod == methods[0]
                    ? _buildActiveMethodButton(
                        'images/logo_app.png', methods[0])
                    : _buildInactiveMethodButton(
                        'images/logo_app.png', methods[0]),
                paymentMethod == methods[1]
                    ? _buildActiveMethodButton('images/paypal.png', methods[1])
                    : _buildInactiveMethodButton(
                        'images/paypal.png', methods[1]),
                paymentMethod == methods[2]
                    ? _buildActiveMethodButton('images/vnpay.png', methods[2])
                    : _buildInactiveMethodButton(
                        'images/vnpay.png', methods[2]),
              ],
            ),
            SizedBox(height: 24.0),
            NeumorphicButton(
              onPressed: () {
                Get.back();
                if (widget.typeOrders == BUY_POINT) {
                  profileController.buyPoint(
                    widget.point,
                    paymentMethod.toUpperCase(),
                  );
                } else if (widget.typeOrders == PAYMENT_ORDERS_MERCHANT) {
                  pickAddressController.paymentCartMerchant(
                      widget.point, paymentMethod.toUpperCase(), context);
                } else {
                  pickAddressController.paymentCartClient(
                      widget.point, paymentMethod.toUpperCase(), context);
                }
              },
              duration: Duration(milliseconds: 200),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(16.0),
                ),
                depth: 20.0,
                intensity: .8,
                color: colorPrimary.withOpacity(.85),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 28.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Thanh toán bằng $paymentMethod',
                    style: TextStyle(
                      color: mC,
                      fontSize: width / 26.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 46.0),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveMethodButton(image, title) {
    return Container(
      height: width * .22,
      width: width * .22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorPrimary, width: 2.5),
      ),
      alignment: Alignment.center,
      child: Container(
        height: width * .2,
        width: width * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInactiveMethodButton(image, title) {
    return GestureDetector(
      onTap: () {
        if (widget.typeOrders != BUY_POINT || title != methods[0]) {
          setState(() {
            paymentMethod = title;
          });
        }
      },
      child: Container(
        height: width * .2,
        width: width * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
