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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mCL,
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
        gestureNavigationEnabled: true,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          if (url
              .toLowerCase()
              .startsWith('$baseUrl/Payment/Paypal/Success'.toLowerCase())) {
            getSnackBar = GetSnackBar(
              title: 'Thanh toán thành công!',
              subTitle: 'Hãy kiểm tra lại giỏ hàng và điểm của bạn.',
            );
            Get.offAndToNamed(Routes.ROOT);
            getSnackBar.show();
          } else if (url
              .toLowerCase()
              .startsWith('$baseUrl/Payment/Paypal/Cancel'.toLowerCase())) {
            getSnackBar = GetSnackBar(
              title: 'Thanh toán thất bại!',
              subTitle: 'Bạn đã huỷ thanh toán thành công.',
            );
            Get.offAndToNamed(Routes.ROOT);
            getSnackBar.show();
          } else if (url
              .toLowerCase()
              .startsWith('$baseUrl/Payment/VNpayReturn'.toLowerCase())) {
            var uri = Uri.parse(url);
            uri.queryParameters.forEach((k, v) {
              if (k == 'vnp_TransactionStatus') {
                if (v == '00') {
                  Get.offAndToNamed(Routes.ROOT);
                  getSnackBar.show();
                  getSnackBar = GetSnackBar(
                    title: 'Thanh toán thành công!',
                    subTitle: 'Hãy kiểm tra lại giỏ hàng và điểm của bạn.',
                  );
                } else {
                  Get.offAndToNamed(Routes.ROOT);
                  getSnackBar.show();
                  getSnackBar = GetSnackBar(
                    title: 'Thanh toán thất bại!',
                    subTitle: 'Bạn đã huỷ thanh toán thành công.',
                  );
                }
              }
            });
          }
        },
      ),
    );
  }
}
