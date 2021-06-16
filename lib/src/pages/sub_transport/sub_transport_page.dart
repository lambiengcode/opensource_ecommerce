import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/sub_transport/controllers/sub_transport_controller.dart';
import 'package:van_transport/src/pages/sub_transport/pages/manage_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class SubTransportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportPage();
}

class _TransportPage extends State<SubTransportPage>
    with SingleTickerProviderStateMixin {
  final subTransportController = Get.put(SubTransportController());
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _pages = [
    SubTransportManageOrderPage(pageName: 'AWAIT_FOR_CONFIRMATION'),
    SubTransportManageOrderPage(pageName: 'ON_GOING'),
    SubTransportManageOrderPage(pageName: 'RECEIVE'),
    SubTransportManageOrderPage(pageName: 'CANCEL'),
    // RevenuePage(),
  ];

  @override
  void initState() {
    super.initState();
    subTransportController.getInfo();
    _tabController = new TabController(
      vsync: this,
      length: 4,
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
        title: StreamBuilder(
          stream: subTransportController.getSubTransportController,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'Đang cập nhật',
                style: TextStyle(
                  color: colorTitle,
                  fontSize: width / 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              );
            }
            return Text(
              snapshot.data['name'] ?? 'Đang cập nhật',
              style: TextStyle(
                color: colorTitle,
                fontSize: width / 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              GetSnackBar getSnackBar = GetSnackBar(
                title: 'Tính năng sắp ra mắt!',
                subTitle: 'Tính năng đang trong quá trình thử nghiệm.',
              );
              getSnackBar.show();
            },
            icon: Icon(
              Feather.filter,
              color: colorTitle,
              size: width / 16.0,
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
              width: width * .26,
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
              width: width * .13,
              child: Tab(
                text: 'reject'.trArgs(),
              ),
            ),
            // Container(
            //   width: width * .18,
            //   child: Tab(
            //     text: 'statistics'.trArgs(),
            //   ),
            // ),
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
