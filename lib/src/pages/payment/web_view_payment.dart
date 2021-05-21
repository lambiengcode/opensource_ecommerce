import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/widgets/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String urlToWeb;
  WebViewPage({this.urlToWeb});
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  GetSnackBar getSnackBar;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mC,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'payment'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WebView(
        initialUrl: widget.urlToWeb,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          if (url.startsWith('$baseUrl/Payment/Success')) {
            getSnackBar = GetSnackBar(
              title: 'Payment Successful',
              subTitle: 'Let\'s check your order again',
            );
            Get.offAndToNamed(Routes.ROOT);
            getSnackBar.show();
          } else if (url.startsWith('$baseUrl/Payment/Cancel')) {
            getSnackBar = GetSnackBar(
              title: 'Payment Failure',
              subTitle: 'An error occurred',
            );
            Get.offAndToNamed(Routes.ROOT);
            getSnackBar.show();
          } else if (url.startsWith('$baseUrl/Payment/VNpayReturn')) {
            var uri = Uri.parse(url);
            uri.queryParameters.forEach((k, v) {
              if (k == 'vnp_TransactionStatus') {
                if (v == '00') {
                  getSnackBar = GetSnackBar(
                    title: 'Payment Successful',
                    subTitle: 'Let\'s check your order again',
                  );
                } else {
                  getSnackBar = GetSnackBar(
                    title: 'Payment Failure',
                    subTitle: 'An error occurred',
                  );
                }
              }
            });
            Get.offAndToNamed(Routes.ROOT);
            getSnackBar.show();
          }
        },
      ),
    );
  }
}
