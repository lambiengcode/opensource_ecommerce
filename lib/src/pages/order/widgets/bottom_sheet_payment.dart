import 'package:ecommerce_ec/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class BottomSheetPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomSheetPaymentState();
}

class _BottomSheetPaymentState extends State<BottomSheetPayment> {
  String paymentMethod = 'Point';
  List<String> methods = ['Point', 'Credit', 'Momo'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 44.0),
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: width * .3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: mCD,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              'Choose payment method',
              style: TextStyle(
                color: colorDarkGrey,
                fontSize: width / 22.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'Lato',
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                paymentMethod == methods[0]
                    ? _buildActiveMethodButton(
                        'https://github.com/lambiengcode/project_college_ec/blob/master/images/logo_app.png?raw=true',
                        methods[0])
                    : _buildInactiveMethodButton(
                        'https://github.com/lambiengcode/project_college_ec/blob/master/images/logo_app.png?raw=true',
                        methods[0]),
                paymentMethod == methods[1]
                    ? _buildActiveMethodButton(
                        'https://image.freepik.com/free-psd/credit-card-mockup_58466-13378.jpg',
                        methods[1])
                    : _buildInactiveMethodButton(
                        'https://image.freepik.com/free-psd/credit-card-mockup_58466-13378.jpg',
                        methods[1]),
                paymentMethod == methods[2]
                    ? _buildActiveMethodButton(
                        'https://upload.wikimedia.org/wikipedia/vi/archive/f/fe/20201011055543%21MoMo_Logo.png',
                        methods[2])
                    : _buildInactiveMethodButton(
                        'https://upload.wikimedia.org/wikipedia/vi/archive/f/fe/20201011055543%21MoMo_Logo.png',
                        methods[2]),
              ],
            ),
            SizedBox(height: 24.0),
            NeumorphicButton(
              onPressed: () => Get.back(),
              duration: Duration(milliseconds: 200),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(16.0),
                ),
                depth: 20.0,
                intensity: .8,
                color: colorPrimary.withOpacity(.85),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 28.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment with $paymentMethod',
                    style: TextStyle(
                      color: mC,
                      fontSize: width / 26.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 46.0),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveMethodButton(image, title) {
    return Container(
      height: width * .22,
      width: width * .22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorPrimary, width: 2.5),
      ),
      alignment: Alignment.center,
      child: Container(
        height: width * .2,
        width: width * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInactiveMethodButton(image, title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          paymentMethod = title;
        });
      },
      child: Container(
        height: width * .2,
        width: width * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
