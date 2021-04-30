import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/pages/revenue_page.dart';
import 'package:van_transport/src/pages/staff/pages/staff_history_page.dart';
import 'package:van_transport/src/pages/staff/pages/staff_ongoing_page.dart';
import 'package:van_transport/src/pages/staff/pages/staff_reject_page.dart';
import 'package:van_transport/src/pages/staff/pages/staff_wait_for_confirm_page.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class SubCityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportPage();
}

class _TransportPage extends State<SubCityPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _pages = [
    StaffWaitForConfirmPage(),
    StaffOngoingPage(),
    StaffRejectPage(),
    StaffHistoryPage(),
    RevenuePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'staff'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.DELIVERY + Routes.EDITDELIVERY),
            icon: Icon(
              Feather.map_pin,
              color: colorPrimary,
              size: width / 17.5,
            ),
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
                text: 'reject'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'history'.trArgs(),
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
        children: _pages.map((Widget tab) {
          return tab;
        }).toList(),
      ),
    );
  }
}
