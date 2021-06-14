import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/widgets/drawer_address.dart';
import 'package:van_transport/src/services/string_service.dart';

class DetailsOrdersPage extends StatefulWidget {
  final data;
  DetailsOrdersPage({@required this.data});
  @override
  State<StatefulWidget> createState() => _DetailsOrdersPageState();
}

class _DetailsOrdersPageState extends State<DetailsOrdersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    // print(widget.data);
    // print(widget.data['canReceive']);
    // print(widget.data['canDelete']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: width * .75,
        child: Drawer(child: DrawerAddress(data: widget.data)),
      ),
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
            size: width / 15.0,
          ),
        ),
        title: Text(
          'detailsOrders'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
            icon: Icon(
              Feather.map,
              color: colorPrimary,
              size: width / 16.5,
            ),
          ),
          SizedBox(width: 4.0),
        ],
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
                          itemCount:
                              widget.data['FK_Product'][0]['products'].length,
                          itemBuilder: (context, index) {
                            return CartCard(
                              name: StringService().formatString(
                                24,
                                widget.data['FK_Product'][0]['products'][index]
                                    ['name'],
                              ),
                              urlToString: widget.data['FK_Product'][0]
                                  ['products'][index]['image'],
                              price: widget.data['FK_Product'][0]['products']
                                  [index]['price'],
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
                          _buildPriceText(context, 'product'.trArgs(),
                              '${widget.data['FK_Product'][0]['products'].length}'),
                          _buildPriceText(
                            context,
                            'subTotal'.trArgs(),
                            StringService().formatPrice(
                                    double.tryParse(widget.data['prices'])
                                        .round()
                                        .toString()) +
                                ' đ',
                          ),
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
              fontSize: width / 28.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ':\t',
            style: TextStyle(
              color: colorDarkGrey.withOpacity(.6),
              fontSize: width / 28.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: colorBlack,
              fontSize: width / 24.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              StringService().formatPrice(double.tryParse(widget.data['prices'])
                      .round()
                      .toString()) +
                  ' đ',
              style: TextStyle(
                color: colorBlack,
                fontSize: width / 22.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                wordSpacing: 1.2,
                letterSpacing: 1.2,
              ),
            ),
            NeumorphicButton(
              onPressed: () {
                if (widget.data['canReceive']) {
                } else if (widget.data['canDelete']) {}
              },
              duration: Duration(milliseconds: 200),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(16.0),
                ),
                depth: 5.0,
                intensity: 1,
                color: !widget.data['canReceive'] && !widget.data['canDelete']
                    ? colorDarkGrey
                    : widget.data['canReceive']
                        ? colorPrimary
                        : colorHigh,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    !widget.data['canReceive'] && !widget.data['canDelete']
                        ? 'Đang giao hàng'
                        : widget.data['canReceive']
                            ? 'Nhận đơn hàng'
                            : 'Huỷ đơn hàng',
                    style: TextStyle(
                      color: !widget.data['canReceive'] &&
                              !widget.data['canDelete']
                          ? mCM
                          : mC,
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
      ),
    );
  }
}
