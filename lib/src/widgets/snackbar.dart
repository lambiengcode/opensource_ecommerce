import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetSnackBar {
  final String title;
  final String subTitle;
  final Size size;
  GetSnackBar({this.title, this.subTitle, this.size});

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
          fontSize: size.width / 24.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        subTitle,
        style: TextStyle(
          fontSize: size.width / 26.0,
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
