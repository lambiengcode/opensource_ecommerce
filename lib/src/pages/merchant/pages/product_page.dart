import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../common/style.dart';
import '../../../common/style.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      color: mC,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildGroupCard();
        },
      ),
    );
  }

  Widget _buildGroupCard() {
    return NeumorphicButton(
      onPressed: () => null,
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(6.0),
        ),
        depth: 4.0,
        intensity: .65,
        color: mC,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shoes',
                style: TextStyle(
                  color: colorTitle,
                  fontFamily: 'Lato',
                  fontSize: width / 26.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'All shoes in my store',
                style: TextStyle(
                  color: colorDarkGrey,
                  fontFamily: 'Lato',
                  fontSize: width / 30.0,
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
