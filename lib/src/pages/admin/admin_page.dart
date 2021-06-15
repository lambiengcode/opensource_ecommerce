import 'package:lottie/lottie.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/admin/controllers/admin_controller.dart';
import 'package:van_transport/src/pages/home/widget/horizontal_store_card.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final adminController = Get.put(AdminController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    adminController.getMerchant('ACTIVE');
    adminController.getTransport('ACTIVE');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: .0,
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
          'Admin',
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mC,
        child: Column(
          children: [
            SizedBox(height: 6.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(
                horizontal: width * .35,
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
            SizedBox(height: 16.0),
            _buildTitle('activeMerchant'.trArgs()),
            SizedBox(height: 16.0),
            StreamBuilder(
              stream: adminController.getMerchantStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: width * .42,
                  );
                }

                return _buildPopularStore(context, snapshot.data, 'MERCHANT');
              },
            ),
            SizedBox(height: 16.0),
            _buildTitle('activeDelivery'.trArgs()),
            SizedBox(height: 16.0),
            StreamBuilder(
              stream: adminController.getTransportStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: width * .42,
                  );
                }

                return _buildPopularStore(context, snapshot.data, 'TRANSPORT');
              },
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: colorDarkGrey,
                height: .2,
                thickness: .2,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: width * .6,
                    width: width * .6,
                    child: Lottie.asset('assets/lottie/splash.json'),
                  ),
                ],
              ),
            ),
            // _buildTitle('promo'.trArgs()),
            // SizedBox(height: 16.0),
            // _buildPopularStore(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(title) {
    return Container(
      padding: EdgeInsets.only(left: 14.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: width / 22.5,
              color: colorTitle,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (title == 'activeMerchant'.trArgs()) {
                Get.toNamed(Routes.ADMIN + Routes.MANAGEMERCHANT);
              } else if (title == 'activeDelivery'.trArgs()) {
                Get.toNamed(Routes.ADMIN + Routes.MANAGETRANSPORT);
              } else {
                Get.toNamed(Routes.ADMIN + Routes.MANAGEPROMO);
              }
            },
            child: Text(
              'viewall'.trArgs(),
              style: TextStyle(
                fontSize: width / 28.0,
                color: colorPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularStore(context, List<dynamic> data, title) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .42,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: HorizontalStoreCard(
              isCover: !(title == 'MERCHANT'),
              title: data[index]['name'],
              urlToImage: title == 'MERCHANT'
                  ? data[index]['image']
                  : data[index]['avatar'],
              address: title == 'MERCHANT'
                  ? data[index]['address']['fullAddress']
                  : data[index]['headquarters'],
              desc: data[index]['description'],
            ),
          );
        },
      ),
    );
  }
}
