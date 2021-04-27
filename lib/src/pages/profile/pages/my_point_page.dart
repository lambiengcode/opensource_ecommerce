import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/widgets/bottom_sheet_payment.dart';

class MyPointPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPointPageState();
}

class _MyPointPageState extends State<MyPointPage> {
  String password = '';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        backgroundColor: mC,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'mypoints'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        color: mC,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6.0),
              Text(
                '69',
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: _size.width / 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'points'.trArgs(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: _size.width / 26.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 24.0),
              _buildMoneyToPoint(context, '100', '20,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '200', '40,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '500', '100,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '1000', '200,000'),
              _buildShadow(context),
              _buildMoneyToPoint(context, '5000', '1,000,000'),
              _buildShadow(context),
              Container(
                padding: EdgeInsets.fromLTRB(14.0, 18.0, 12.0, 20.0),
                margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: colorTitle,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Feather.plus,
                      color: colorPrimaryTextOpacity,
                      size: _size.width / 25.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.25),
                      child: Text(
                        'customizePoint'.trArgs(),
                        style: TextStyle(
                          color: colorPrimaryTextOpacity,
                          fontSize: _size.width / 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoneyToPoint(context, title, value) {
    final _size = MediaQuery.of(context).size;
    void showPaymentBottomSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BottomSheetPayment();
        },
      );
    }

    return GestureDetector(
      onTap: () => showPaymentBottomSheet(),
      child: Container(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 12.0, 18.0),
        margin: EdgeInsets.symmetric(horizontal: 32.0),
        decoration: BoxDecoration(
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(10, 10),
              blurRadius: 10,
            ),
            BoxShadow(
              color: mCL,
              offset: Offset(-10, -10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title + ' ',
                    style: TextStyle(
                      fontSize: _size.width / 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'points'.trArgs().toLowerCase(),
                    style: TextStyle(
                      fontSize: _size.width / 28.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              value + ' đ',
              style: TextStyle(
                color: colorPrimary,
                fontSize: _size.width / 23.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShadow(context) {
    return Container(
      height: 16.0,
      color: Colors.transparent,
    );
  }

  Widget _choosePaymentMethod(context, value) {
    final _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .35),
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
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total'.trArgs(),
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 22.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value + ' đ',
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: _size.width / 23.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(
              color: Colors.grey.shade400,
              thickness: .25,
              height: .25,
            ),
            SizedBox(height: 16.0),
            Text(
              'selectcard'.trArgs(),
              style: TextStyle(
                color: fCD,
                fontSize: _size.width / 22.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.fromLTRB(14.0, 12.0, 18.0, 4.0),
              child: TextFormField(
                cursorColor: colorTitle,
                cursorRadius: Radius.circular(30.0),
                style: TextStyle(
                  color: colorTitle,
                  fontSize: _size.width / 24.0,
                  fontWeight: FontWeight.w500,
                ),
                validator: (val) => val.trim().length < 6 ? 'validpsw' : null,
                onChanged: (val) => password = val.trim(),
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.only(
                    left: 12.0,
                  ),
                  border: InputBorder.none,
                  labelText: 'PIN',
                  labelStyle: TextStyle(
                    color: colorTitle,
                    fontSize: _size.width / 26.0,
                    fontWeight: FontWeight.w600,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Text(
                      'Send SMS (60)',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: _size.width / 32.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: .25,
              height: .25,
              indent: 25.0,
              endIndent: 25.0,
            ),
            SizedBox(height: 24.0),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 46.8,
                margin: EdgeInsets.symmetric(
                  horizontal: _size.width * .08,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: colorTitle,
                ),
                child: Center(
                  child: Text(
                    'cfmpayment'.trArgs(),
                    style: TextStyle(
                      color: colorPrimaryTextOpacity,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 36.0),
          ],
        ),
      ),
    );
  }
}
