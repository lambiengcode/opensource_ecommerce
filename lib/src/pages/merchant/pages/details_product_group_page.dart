import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import '../../../common/style.dart';
import '../../../routes/app_pages.dart';
import '../../home/widget/vertical_store_card.dart';

class DetailsProductGroupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailsProductGroupPageState();
}

class _DetailsProductGroupPageState extends State<DetailsProductGroupPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Shoes',
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
              Feather.edit_3,
              color: colorTitle,
              size: width / 16.0,
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: width / 6.25,
        width: width / 6.25,
        child: FloatingActionButton(
          backgroundColor: colorTitle,
          child: Icon(
            Feather.plus,
            color: colorPrimaryTextOpacity,
            size: width / 16.0,
          ),
          onPressed: () => Get.toNamed(Routes.MERCHANT + Routes.CREATEPRODUCT),
        ),
      ),
      key: _scaffoldKey,
      body: Container(
        color: mC,
        height: height,
        width: width,
        margin: EdgeInsets.only(top: 12.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.toNamed(Routes.MERCHANT + Routes.EDITPRODUCT),
              child: VerticalStoreCard(),
            );
          },
        ),
      ),
    );
  }
}
