import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mC,
        elevation: .0,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          'notifications'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SETTINGS),
            icon: Icon(
              Feather.settings,
              color: colorTitle,
              size: _size.width / 16.0,
            ),
          ),
        ],
      ),
      body: Container(
        color: mC,
      ),
    );
  }
}
