import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_client_controller.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/pages/order/widgets/bottom_sheet_payment.dart';
import 'package:van_transport/src/pages/order/widgets/product_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class CheckOutOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckOutOrderPageState();
}

class _CheckOutOrderPageState extends State<CheckOutOrderPage> {
  final pickAddressController = Get.put(PickAddressController());
  final cartController = Get.put(CartClientController());

  @override
  void initState() {
    super.initState();
    cartController.getListCart();
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
        child: StreamBuilder(
          stream: cartController.getListCartController,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            double weight = 0.0;
            snapshot.data.forEach((e) {
              weight += double.tryParse(e['weight'].replaceAll(',', ''));
            });

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
                                return ProductOrderCard(
                                  name: snapshot.data[index]['name'],
                                  weight: snapshot.data[index]['weight'],
                                  typeProduct: snapshot.data[index]['type'],
                                  urlToImage: snapshot.data[index]['image'][0],
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildPriceText(context, 'weight'.trArgs(),
                                        '${weight.toStringAsFixed(1)} Kg'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<PickAddressController>(
                                      builder: (_) => _buildPriceText(
                                          context,
                                          'distance'.trArgs(),
                                          '${_.distance == null ? 'Calculating' : _.distance}'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildBottomCheckout(context, weight.toStringAsFixed(2)),
              ],
            );
          },
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
              fontSize: width / 28.5,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ':\t\t',
            style: TextStyle(
              color: colorDarkGrey.withOpacity(.6),
              fontSize: width / 28.5,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: colorBlack,
              fontSize: width / 25.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckout(context, weight) {
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
          return BottomSheetPayment(
            typeOrders: PAYMENT_ORDERS_CLIENT,
            point: weight,
          );
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
            GetBuilder<PickAddressController>(
                builder: (_) => _buildActionValue(
                      'transport'.trArgs(),
                      _.transportInfo == null
                          ? 'chooseTransport'.trArgs()
                          : _.transportInfo['FK_Transport']['name'],
                    )),
            SizedBox(height: 16.0),
            _buildActionValue('taxes'.trArgs(), '200 đ'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<PickAddressController>(
                  builder: (_) => Text(
                    '${_.transportInfo != null ? StringService().formatPrice((double.tryParse(_.transportInfo['price']) + 200).round().toString()) : StringService().formatPrice((200).toString())} đ',
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: width / 20.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1.2,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                NeumorphicButton(
                  onPressed: () {
                    if (pickAddressController.transportInfo == null) {
                      GetSnackBar getSnackBar = GetSnackBar(
                        title: 'Không thể thanh toán đơn hàng',
                        subTitle: 'Bạn chưa chọn nhà vận chuyển',
                      );
                      getSnackBar.show();
                    } else {
                      showPaymentBottomSheet();
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
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.PICKDELIVERY);
          },
          child: Text(
            value,
            style: TextStyle(
              color: value == 'chooseCoupon'.trArgs() ||
                      value == 'chooseTransport'.trArgs()
                  ? colorPrimary
                  : colorTitle,
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
