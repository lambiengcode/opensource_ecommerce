import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/pages/order/widgets/bottom_sheet_payment.dart';
import 'package:ecommerce_ec/src/pages/order/widgets/product_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class CheckOutOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckOutOrderPageState();
}

class _CheckOutOrderPageState extends State<CheckOutOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mCL,
        elevation: .0,
        centerTitle: true,
        leadingWidth: 62.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 16.5,
          ),
        ),
        title: Text(
          'checkOut'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mCL,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50.0),
                  ),
                  color: mCM.withOpacity(.85),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            left: 12.5,
                            right: 12.5,
                            top: 16.0,
                          ),
                          physics: ClampingScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return ProductOrderCard();
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildPriceText(context, 'Total Weight', '2 Kg'),
                          _buildPriceText(context, 'Taxes', '\$5'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomCheckout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceText(context, title, value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: colorDarkGrey.withOpacity(.6),
              fontSize: width / 24.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ':\t',
            style: TextStyle(
              color: colorDarkGrey,
              fontSize: width / 24.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: colorBlack,
              fontSize: width / 22.5,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckout(context) {
    void showPaymentBottomSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BottomSheetPayment();
        },
      );
    }

    return Container(
      color: mCM,
      child: Neumorphic(
        padding: EdgeInsets.fromLTRB(32.0, 32.0, 24.0, 32.0),
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
          depth: -20.0,
          intensity: .6,
          color: mCH.withOpacity(.12),
        ),
        child: Column(
          children: [
            _buildActionValue('Transport', 'Ahamove'),
            SizedBox(height: 18.0),
            _buildActionValue('Coupon', 'Pick Coupon'),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$260',
                  style: TextStyle(
                    color: colorBlack,
                    fontSize: width / 16.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.2,
                    letterSpacing: 1.2,
                  ),
                ),
                NeumorphicButton(
                  onPressed: () => showPaymentBottomSheet(),
                  duration: Duration(milliseconds: 200),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(20.0),
                    ),
                    depth: 15.0,
                    intensity: 1,
                    color: colorPrimary.withOpacity(.85),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 28.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: mC,
                        size: width / 18.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'payment'.trArgs(),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionValue(title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 24.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: value == 'Pick Coupon' || value == 'Pick Transport'
                ? colorPrimary
                : colorTitle,
            fontSize: width / 24.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
