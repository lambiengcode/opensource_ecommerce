import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/empty/empty_order_page.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';
import 'package:van_transport/src/pages/merchant/pages/manage_order_merchant_page.dart';
import 'package:van_transport/src/pages/merchant/pages/product_page.dart';
import 'package:van_transport/src/pages/merchant/pages/revenue_page.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class MerchantPage extends StatefulWidget {
  final merchantInfo;
  MerchantPage({this.merchantInfo});
  @override
  State<StatefulWidget> createState() => _TransportPage();
}

class _TransportPage extends State<MerchantPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final merchantController = Get.put(MerchantController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFloatingButton = false;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    merchantController.getMerchant();
    _tabController = new TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      setState(() {
        _tabController.index == 3
            ? _showFloatingButton = true
            : _showFloatingButton = false;
      });
    });
    _pages = [
      ManageOrderMerchantPage(pageName: 'AWAIT_FOR_CONFIRMATION'),
      ManageOrderMerchantPage(pageName: 'ON_GOING'),
      ManageOrderMerchantPage(pageName: 'DELIVERED'),
      ProductPage(idMerchant: widget.merchantInfo['_id']),
      RevenuePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: _showFloatingButton
          ? Container(
              height: width / 6.25,
              width: width / 6.25,
              child: FloatingActionButton(
                backgroundColor: colorTitle,
                child: Icon(
                  Feather.plus,
                  color: colorPrimaryTextOpacity,
                  size: width / 16.0,
                ),
                onPressed: () => Get.toNamed(
                  Routes.MERCHANT + Routes.CREATEGROUP,
                  arguments: widget.merchantInfo['_id'],
                ),
              ),
            )
          : null,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: 1.5,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 15.0,
          ),
        ),
        title: Text(
          'merchant'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          StreamBuilder(
            stream: merchantController.getMerchantStream,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return IconButton(
                onPressed: () => Get.toNamed(
                  Routes.MERCHANT + Routes.EDITMERCHANT,
                  arguments: snapshot.data,
                ),
                icon: Icon(
                  Feather.edit_3,
                  color: colorTitle,
                  size: width / 16.0,
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: colorPrimary,
          indicatorColor: colorPrimary,
          unselectedLabelColor: colorTitle.withOpacity(.825),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 1.75,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width / 28.5,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width / 28.5,
          ),
          tabs: [
            Container(
              width: Get.locale == Locale('vi', 'VN')
                  ? width * .265
                  : width * .305,
              child: Tab(
                text: 'waitForConfirm'.trArgs(),
              ),
            ),
            Container(
              width: width * .185,
              child: Tab(
                text: 'onGoing'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'history'.trArgs(),
              ),
            ),
            Container(
              width:
                  Get.locale == Locale('vi', 'VN') ? width * .18 : width * .16,
              child: Tab(
                text: 'product'.trArgs(),
              ),
            ),
            Container(
              width: width * .18,
              child: Tab(
                text: 'statistics'.trArgs(),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages.map((Widget tab) {
          return tab;
        }).toList(),
      ),
    );
  }
}
