import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_client_controller.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/pages/order/widgets/product_order_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class PickAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  final pickAddressController = Get.put(PickAddressController());
  final stringService = StringService();
  final cartController = Get.put(CartClientController());

  void chooseLocation(context) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PlacePicker(
              apiKey: apiMap,
              initialPosition: kInitialPosition,
              useCurrentLocation: true,
              selectInitialPosition: true,
              onGeocodingSearchFailed: (error) => print(error),
              usePlaceDetailSearch: true,
              forceSearchOnZoomChanged: true,
              automaticallyImplyAppBarLeading: false,
              usePinPointingSearch: true,
              autocompleteLanguage:
                  Get.locale == Locale('vi', 'VN') ? 'vi' : 'en',
              region: Get.locale == Locale('vi', 'VN') ? 'vn' : 'us',
              selectedPlaceWidgetBuilder:
                  (_, selectedP, state, isSearchBarFocused) {
                print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                return isSearchBarFocused
                    ? Container()
                    : FloatingCard(
                        bottomPosition: 0.0,
                        leftPosition: 0.0,
                        rightPosition: 0.0,
                        width: 600.0,
                        height: 125.0,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: state == SearchingState.Searching
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    colorTitle,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      selectedP.formattedAddress,
                                      style: TextStyle(
                                          color: colorTitle,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 600.0,
                                      child: RaisedButton(
                                        color: colorTitle,
                                        child: Text(
                                          'pick'.trArgs(),
                                          style: TextStyle(
                                            color: colorPrimaryTextOpacity,
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      );
              },
              pinBuilder: (context, state) {
                if (state == PinState.Idle) {
                  return CircleAvatar(
                    radius: 12.0,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/60530946?v=4',
                    ),
                  );
                } else {
                  return CircleAvatar(
                    radius: 12.0,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/60530946?v=4',
                    ),
                  );
                }
              },
            );
          },
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    pickAddressController.initData();
    cartController.getListCart();
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
          stream: cartController.getListCartController,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
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
                                return ProductOrderCard(
                                  name: snapshot.data[index]['name'],
                                  weight: snapshot.data[index]['weight'],
                                  typeProduct: snapshot.data[index]['type'],
                                  urlToImage: snapshot.data[index]['image'][0],
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GetBuilder<PickAddressController>(
                  builder: (_) => _buildBottomCheckout(
                    context,
                    _.placeFrom,
                    _.placeTo,
                    snapshot.data.length,
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
              'fromAddress'.trArgs(),
              fromAddress == ''
                  ? 'pick'.trArgs()
                  : stringService.formatString(18, fromAddress),
            ),
            SizedBox(height: 18.0),
            _buildAddressValue(
                'toAddress'.trArgs(),
                toAddress == ''
                    ? 'pick'.trArgs()
                    : stringService.formatString(18, toAddress)),
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
                      if (_.placeFrom != '' && _.placeTo != '') {
                        pickAddressController.calDistance();
                        Get.toNamed(Routes.CHECKOUTORDER);
                      } else {
                        GetSnackBar getSnackBar = GetSnackBar(
                          title: 'Hãy chọn vị trí!',
                          subTitle: 'Chọn nơi nhận hàng và nơi lấy hàng',
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
            title == 'toAddress'.trArgs()
                ? Get.toNamed(Routes.INPUTINFOREVICER)
                : Get.toNamed(
                    Routes.ADDRESS,
                    arguments: {
                      'pickMode': PICK_ON,
                      'isFrom': true,
                    },
                  );
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
