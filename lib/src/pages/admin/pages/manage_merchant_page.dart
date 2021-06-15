import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/admin/controllers/admin_controller.dart';
import 'package:van_transport/src/pages/admin/widgets/manage_merchant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ManageMerchantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageMerchantPageState();
}

class _ManageMerchantPageState extends State<ManageMerchantPage>
    with SingleTickerProviderStateMixin {
  final adminController = Get.put(AdminController());
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _pages = [
    ManageMerchantList(pageName: 'ACTIVE'),
    ManageMerchantList(pageName: 'INACTIVE'),
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
          onPressed: () {
            adminController.getMerchant('ACTIVE');
            Get.back();
          },
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
              text: 'activeMerchant'.trArgs(),
            ),
            Tab(
              text: 'pendingMerchant'.trArgs(),
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
