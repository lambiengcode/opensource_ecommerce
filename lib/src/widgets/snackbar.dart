import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';

class GetSnackBar {
  final String title;
  final String subTitle;
  GetSnackBar({this.title, this.subTitle});

  show() {
    Get.snackbar(
      '',
      '',
      colorText: Colors.white,
      backgroundColor: Colors.black45,
      duration: Duration(
        milliseconds: 2000,
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: width / 24.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        subTitle,
        style: TextStyle(
          fontSize: width / 26.0,
          color: Colors.white.withOpacity(.85),
          fontWeight: FontWeight.w400,
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20.0,
        20.0,
        8.0,
        18.0,
      ),
    );
  }
}
