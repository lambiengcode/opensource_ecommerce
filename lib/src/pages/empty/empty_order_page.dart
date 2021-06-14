import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmptyOrderPageState();
}

class _EmptyOrderPageState extends State<EmptyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mC,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: width * .85,
              width: width * .85,
              child: Lottie.asset('assets/lottie/lottie_order.json'),
            ),
            Text(
              'Chưa có đơn hàng nào.',
              style: TextStyle(
                color: colorDarkGrey,
                fontSize: width / 24.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lato',
              ),
            ),
            SizedBox(height: height * .1),
          ],
        ),
      ),
    );
  }
}
