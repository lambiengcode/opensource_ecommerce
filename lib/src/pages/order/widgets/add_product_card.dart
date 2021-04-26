import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AddProductCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * .3,
      margin: EdgeInsets.only(bottom: 8.0, left: 12.0),
      child: Container(
        height: width * .295,
        margin: EdgeInsets.only(top: 6.0),
        padding: EdgeInsets.only(right: 20.0, left: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
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
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: width * .2,
                    height: width * .2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorPrimary,
                        width: 2.5,
                      ),
                    ),
                    child: Icon(
                      Feather.plus,
                      color: colorPrimary,
                      size: width / 14.0,
                    ),
                  ),
                  SizedBox(width: 14.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add New Product to Order',
                        style: TextStyle(
                          color: colorTitle,
                          fontSize: width / 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Unknown ',
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: width / 24.0,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Kg',
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: width / 24.0,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
