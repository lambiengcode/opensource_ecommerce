import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_merchant_controller.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/pages/order/widgets/bottom_sheet_payment.dart';
import 'package:van_transport/src/pages/order/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class CheckOutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final pickAddressController = Get.put(PickAddressController());
  final cartController = Get.put(CartMerchantController());

  @override
  void initState() {
    super.initState();
    cartController.getCartMerchant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          stream: cartController.getCartController,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            int quantity = 0;
            int price = 0;
            for (int i = 0; i < snapshot.data.length; i++) {
              quantity += snapshot.data[i]['quantity'];
              price += int.parse(snapshot.data[i]['product']['price']) *
                  snapshot.data[i]['quantity'];
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
                        Container(
                          padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPriceText(
                                  context, 'product'.trArgs(), '$quantity'),
                              _buildPriceText(
                                context,
                                'subTotal'.trArgs(),
                                '${StringService().formatPrice(price.toString())} đ',
                              ),
                              _buildPriceText(
                                  context, 'taxes'.trArgs(), '200 đ'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildBottomCheckout(
                  context,
                  snapshot.data[0]['FK_merchant'],
                  StringService().formatPrice(price.toString()),
                ),
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
              fontSize: width / 32.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ':\t',
            style: TextStyle(
              color: colorDarkGrey.withOpacity(.6),
              fontSize: width / 26.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: colorBlack,
              fontSize: width / 26.5,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckout(context, idMerchant, price) {
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
            typeOrders: PAYMENT_ORDERS_MERCHANT,
            point: price,
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
            SizedBox(height: 16.0),
            // _buildActionValue('myvoucher'.trArgs(), 'chooseCoupon'.trArgs()),
            // SizedBox(height: 16.0),
            GetBuilder<PickAddressController>(
                builder: (_) => _buildActionValue(
                    'transport'.trArgs(),
                    _.transportInfo == null
                        ? 'chooseTransport'.trArgs()
                        : _.transportInfo['FK_Transport']['name'],
                    idMerchant)),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<PickAddressController>(
                  builder: (_) => Text(
                    '${_.transportInfo != null ? StringService().formatPrice((int.parse(price.replaceAll(',', '')) + double.tryParse(_.transportInfo['price']) + 200).round().toString()) : StringService().formatPrice((int.parse(price.replaceAll(',', '')) + 200).toString())} đ',
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
                    // showPaymentBottomSheet();
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

  Widget _buildActionValue(title, value, idMerchant) {
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
          onTap: () => Get.toNamed(Routes.PICKDELIVERY, arguments: idMerchant),
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
