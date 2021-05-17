import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';
import 'package:van_transport/src/routes/app_pages.dart';

class ProductPage extends StatefulWidget {
  final String idMerchant;
  ProductPage({this.idMerchant});
  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final merchantController = Get.put(MerchantController());

  @override
  void initState() {
    super.initState();
    merchantController.getGroupProduct(widget.idMerchant);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      color: mC,
      child: StreamBuilder(
        stream: merchantController.getGroupProductStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          var mGroupProduct = snapshot.data;

          return ListView.builder(
            itemCount: mGroupProduct.length,
            itemBuilder: (context, index) {
              return _buildGroupCard(mGroupProduct[index]['name']);
            },
          );
        },
      ),
    );
  }

  Widget _buildGroupCard(title) {
    return NeumorphicButton(
      onPressed: () =>
          Get.toNamed(Routes.MERCHANT + Routes.DETAILSGROUP, arguments: {
        'title': title,
        'idMerchant': widget.idMerchant,
      }),
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
                title,
                style: TextStyle(
                  color: colorTitle,
                  fontFamily: 'Lato',
                  fontSize: width / 24.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                title,
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
