import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/pages/order/widgets/product_order_card.dart';
import 'package:ecommerce_ec/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class PickAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
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
          'pickAddress'.trArgs(),
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

  Widget _buildBottomCheckout(context) {
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
            _buildAddressValue('To Address', '1 Võ Văn Ngân,..'),
            SizedBox(height: 18.0),
            _buildAddressValue('From Address', 'Pick Address'),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Product:\t\t',
                        style: TextStyle(
                          color: colorDarkGrey,
                          fontSize: width / 24.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '2',
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: width / 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                NeumorphicButton(
                  onPressed: () => Get.toNamed(Routes.CHECKOUTORDER),
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
                        Icons.sensor_door,
                        color: mC,
                        size: width / 18.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'checkOut'.trArgs(),
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

  Widget _buildAddressValue(title, value) {
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
            color: value == 'Pick Address' ? colorPrimary : colorTitle,
            fontSize: width / 24.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
