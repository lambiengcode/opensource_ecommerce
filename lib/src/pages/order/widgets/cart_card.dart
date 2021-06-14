import 'package:cached_network_image/cached_network_image.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_merchant_controller.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class CartCard extends StatefulWidget {
  final String name;
  final String price;
  final String quantity;
  final String urlToString;
  final String idProduct;
  CartCard({
    @required this.name,
    @required this.price,
    this.quantity,
    @required this.urlToString,
    this.idProduct,
  });
  @override
  State<StatefulWidget> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .3,
      margin: EdgeInsets.only(bottom: 8.0, left: 12.0),
      child: Stack(
        children: [
          Container(
            height: _size.width * .295,
            margin: EdgeInsets.only(top: 6.0),
            padding: EdgeInsets.only(right: 20.0, left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
              color: mC,
              boxShadow: [
                BoxShadow(
                  color: mCD,
                  offset: Offset(10, 10),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: mCL,
                  offset: Offset(-10, -10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: _size.width * .2,
                        height: _size.width * .2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorPrimary,
                            width: 2.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000.0),
                          child: CachedNetworkImage(
                            width: _size.width * .175,
                            height: _size.width * .175,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => PlaceHolderImage(),
                            errorWidget: (context, url, error) =>
                                ErrorLoadingImage(),
                            imageUrl: widget.urlToString,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: colorTitle,
                              fontSize: width / 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      StringService().formatPrice(widget.price),
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: width / 22.5,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' đ',
                                  style: TextStyle(
                                    color: colorPrimary,
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
                widget.quantity != null
                    ? _buildQuantityButton(context)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuantityActionButton(context, Feather.minus),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            widget.quantity,
            style: TextStyle(
              color: colorBlack,
              fontSize: width / 28.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        _buildQuantityActionButton(context, Feather.plus),
      ],
    );
  }

  Widget _buildQuantityActionButton(context, icon) {
    final cartController = Get.put(CartMerchantController());
    return NeumorphicButton(
      onPressed: () {
        if (widget.idProduct != null) {
          if (icon == Feather.minus && int.parse(widget.quantity) > 1) {
            cartController.updateCart(
                widget.idProduct, (int.parse(widget.quantity) - 1).toString());
          } else {
            cartController.updateCart(
                widget.idProduct, (int.parse(widget.quantity) + 1).toString());
          }
        }
      },
      child: Icon(
        icon,
        size: width / 32.0,
        color: colorPrimary,
      ),
      padding: EdgeInsets.all(width / 38.0),
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 5.0,
        intensity: .7,
        color: Colors.white.withOpacity(.5),
      ),
      duration: Duration(milliseconds: 200),
    );
  }
}
