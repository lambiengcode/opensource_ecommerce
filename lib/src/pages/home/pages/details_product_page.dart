import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_merchant_controller.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/services/string_service.dart';

class DetailsProductPage extends StatefulWidget {
  final String image;
  final String price;
  final String name;
  final String description;
  final String owner;
  final data;

  DetailsProductPage({
    this.description,
    this.image,
    this.name,
    this.owner,
    this.price,
    @required this.data,
  });

  @override
  State<StatefulWidget> createState() => _DetailsProductPageState();
}

class _DetailsProductPageState extends State<DetailsProductPage> {
  final cartController = Get.put(CartMerchantController());
  int _quantity = 1;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Container(
                height: height * .5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Container(
                height: height * .5,
                decoration: BoxDecoration(
                  color: colorBlack.withOpacity(.5),
                ),
              ),
            ),
            Positioned(
              top: height / 18.0,
              left: .0,
              right: .0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopbarButton(context, Feather.arrow_left),
                    _buildTopbarButton(context, Feather.shopping_bag),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: .0,
              left: .0,
              right: .0,
              child: Container(
                height: height * .56,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(40.0),
                    ),
                    depth: -.25,
                    intensity: 1.0,
                    color: mCM,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.0),
                      Container(
                        height: 4.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: width * .32,
                        ),
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
                      SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringService().formatString(
                                    60,
                                    widget.description.replaceAll('\n', '. '),
                                  ),
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontSize: width / 20.0,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                GestureDetector(
                                  onTap: () => Get.toNamed(Routes.STORE,
                                      arguments: widget.data['FK_merchant']),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Store: ',
                                            style: TextStyle(
                                              color: colorTitle,
                                              fontSize: width / 24.0,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        TextSpan(
                                          text: widget.owner,
                                          style: TextStyle(
                                            color: colorPrimary,
                                            fontSize: width / 24.0,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Feather.heart,
                              color: colorHigh,
                              size: width / 16.0,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.AUTHENTICATION);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Details',
                        style: TextStyle(
                          color: colorBlack,
                          fontSize: width / 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        StringService().formatString(
                            240, widget.description.replaceAll('\n', '. ')),
                        style: TextStyle(
                          color: colorTitle,
                          fontSize: width / 24.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 28.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildQuantityButton(context),
                          Text(
                            'Total: \$260',
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: width / 22.5,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              wordSpacing: 1.2,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28.0),
                      NeumorphicButton(
                        onPressed: () {
                          if (App.token == '') {
                            Get.toNamed(Routes.AUTHENTICATION);
                          } else {
                            cartController.addToCart(
                              widget.data['FK_product'],
                              _quantity.toString(),
                            );
                          }
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20.0),
                          ),
                          depth: -.5,
                          intensity: 1,
                          color: colorPrimary.withOpacity(.85),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                              color: mC,
                              size: width / 18.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: mC,
                                fontSize: width / 26.0,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        duration: Duration(milliseconds: 200),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopbarButton(context, icon) {
    final _size = MediaQuery.of(context).size;
    return NeumorphicButton(
      onPressed: () {
        if (icon == Feather.arrow_left) {
          Get.back();
        } else {
          App.token == ''
              ? Get.toNamed(Routes.AUTHENTICATION)
              : Get.toNamed(Routes.CART);
        }
      },
      child: Icon(
        icon,
        size: _size.width / 18.0,
        color: mC,
      ),
      padding: EdgeInsets.all(_size.width / 28.0),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(10.0),
        ),
        depth: -.5,
        intensity: 1,
        color: mCL.withOpacity(.15),
      ),
      duration: Duration(milliseconds: 500),
    );
  }

  Widget _buildQuantityButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildQuantityActionButton(context, Feather.minus),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$_quantity',
            style: TextStyle(
              color: colorTitle,
              fontSize: width / 26.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildQuantityActionButton(context, Feather.plus),
      ],
    );
  }

  Widget _buildQuantityActionButton(context, icon) {
    return NeumorphicButton(
      onPressed: () {
        setState(() {
          if (icon == Feather.plus) {
            _quantity++;
          } else if (_quantity > 1) {
            _quantity--;
          }
        });
      },
      child: Icon(
        icon,
        size: width / 24.0,
        color: colorPrimary,
      ),
      padding: EdgeInsets.all(width / 32.0),
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12.0),
        ),
        depth: .5,
        intensity: 1,
        color: Colors.white.withOpacity(.5),
      ),
      duration: Duration(milliseconds: 200),
    );
  }
}
