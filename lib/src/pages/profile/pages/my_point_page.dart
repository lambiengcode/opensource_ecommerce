import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/widgets/bottom_sheet_payment.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';

class MyPointPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPointPageState();
}

class _MyPointPageState extends State<MyPointPage> {
  final profileController = Get.put(ProfileController());
  String password = '';

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        backgroundColor: mC,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'mypoints'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        color: mC,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.0),
              StreamBuilder(
                stream: profileController.getProfileController,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      'Loading...',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: _size.width / 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lato',
                      ),
                    );
                  }
                  return Text(
                    snapshot.data['point'].toString(),
                    style: TextStyle(
                      color: colorPrimary,
                      fontSize: _size.width / 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              SizedBox(height: 6.0),
              Text(
                'points'.trArgs(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: _size.width / 26.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 28.0),
              _buildMoneyToPoint(context, '200', '20,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '400', '40,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '1000', '100,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '2000', '200,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '10000', '1,000,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '20000', '2,000,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '50000', '5,000,000'),
              _buildShadow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoneyToPoint(context, title, value) {
    final _size = MediaQuery.of(context).size;
    void showPaymentBottomSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BottomSheetPayment(
            typeOrders: BUY_POINT,
            point: title,
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => showPaymentBottomSheet(),
      child: Container(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 12.0, 18.0),
        margin: EdgeInsets.symmetric(horizontal: 32.0),
        decoration: BoxDecoration(
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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title + ' ',
                    style: TextStyle(
                      fontSize: _size.width / 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'points'.trArgs().toLowerCase(),
                    style: TextStyle(
                      fontSize: _size.width / 28.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              value + ' đ',
              style: TextStyle(
                color: colorPrimary,
                fontSize: _size.width / 23.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShadow(context) {
    return Container(
      height: 16.0,
      color: Colors.transparent,
    );
  }
}
