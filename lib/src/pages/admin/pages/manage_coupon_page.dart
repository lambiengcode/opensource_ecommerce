import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/admin/widgets/manage_coupon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ManageCouponPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageCouponPageState();
}

class _ManageCouponPageState extends State<ManageCouponPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _pages = [
    ManageCouponList(),
    ManageCouponList(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'promo'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(
              Feather.plus_square,
              color: colorTitle,
              size: width / 16.0,
            ),
          ),
        ],
        bottom: TabBar(
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
            Tab(
              text: 'activePromo'.trArgs(),
            ),
            Tab(
              text: 'inactivePromo'.trArgs(),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages.map((Widget tab) {
          return tab;
        }).toList(),
      ),
    );
  }
}
