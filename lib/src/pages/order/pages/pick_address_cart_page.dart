import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_merchant_controller.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/pages/order/widgets/cart_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class PickAddressCartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PickAddressCartPageState();
}

class _PickAddressCartPageState extends State<PickAddressCartPage> {
  final pickAddressController = Get.put(PickAddressController());
  final stringService = StringService();

  final cartController = Get.put(CartMerchantController());

  @override
  void initState() {
    super.initState();
    cartController.getCartMerchant();
    pickAddressController.initData();
  }

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
        child: StreamBuilder(
          stream: cartController.getCartController,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            int quantity = 0;
            for (int i = 0; i < snapshot.data.length; i++) {
              quantity += snapshot.data[i]['quantity'];
            }

            return Column(
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
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
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
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return CartCard(
                                  name: StringService().formatString(
                                    20,
                                    snapshot.data[index]['product']['name'],
                                  ),
                                  quantity: snapshot.data[index]['quantity']
                                      .toString(),
                                  price: snapshot.data[index]['product']
                                          ['price']
                                      .toString(),
                                  urlToString: snapshot.data[index]['product']
                                      ['image'],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<PickAddressController>(
                  builder: (_) => _buildBottomCheckout(
                    context,
                    _.placeFrom,
                    _.placeTo,
                    quantity,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomCheckout(context, fromAddress, toAddress, quantity) {
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
            _buildAddressValue(
                'toAddress'.trArgs(),
                fromAddress == ''
                    ? 'pick'.trArgs()
                    : stringService.formatString(18, fromAddress)),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${'product'.trArgs()}:\t\t',
                        style: TextStyle(
                          color: colorDarkGrey,
                          fontSize: width / 24.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '$quantity',
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
                GetBuilder<PickAddressController>(
                  builder: (_) => NeumorphicButton(
                    onPressed: () {
                      if (_.placeFrom != '') {
                        Get.toNamed(Routes.CHECKOUT);
                      } else {
                        GetSnackBar getSnackBar = GetSnackBar(
                          title: 'Please pick address!',
                          subTitle: 'Pick from and to address now.',
                        );
                        getSnackBar.show();
                      }
                    },
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
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.ADDRESS, arguments: PICK_ON);
          },
          child: Text(
            value,
            style: TextStyle(
              color: value == 'pick'.trArgs() ? colorPrimary : colorTitle,
              fontSize: width / 24.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
