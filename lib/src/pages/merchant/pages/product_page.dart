import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/routes/app_pages.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      color: mC,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return _buildGroupCard();
        },
      ),
    );
  }

  Widget _buildGroupCard() {
    return NeumorphicButton(
      onPressed: () => Get.toNamed(Routes.MERCHANT + Routes.DETAILSGROUP),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(6.0),
        ),
        depth: 2.0,
        intensity: .5,
        color: mCL,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shoes',
                style: TextStyle(
                  color: colorTitle,
                  fontFamily: 'Lato',
                  fontSize: width / 24.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'All shoes in my store',
                style: TextStyle(
                  color: colorDarkGrey,
                  fontFamily: 'Lato',
                  fontSize: width / 28.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorPrimary,
            size: width / 18.0,
          ),
        ],
      ),
      duration: Duration(milliseconds: 200),
    );
  }
}
