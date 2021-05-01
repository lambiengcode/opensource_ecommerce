import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:get/get.dart';

class SubCityCard extends StatefulWidget {
  final String fullName;
  final String manager;
  final String address;
  SubCityCard({this.fullName, this.manager, this.address});
  @override
  State<StatefulWidget> createState() => _SubCityCardState();
}

class _SubCityCardState extends State<SubCityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
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
        children: [
          Container(
            width: width * .18,
            height: width * .18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
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
            child: Icon(
              Feather.map_pin,
              color: colorPrimary,
              size: width / 14.0,
            ),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FullName: ${widget.fullName}',
                style: TextStyle(
                  color: colorTitle,
                  fontSize: width / 24.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Lato',
                ),
              ),
              SizedBox(height: 6.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Phone: ',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: width / 28.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: widget.manager,
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: width / 26.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${('address'.trArgs())}: ',
                      style: TextStyle(
                        color: colorTitle,
                        fontSize: width / 28.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: widget.address.length > 26
                          ? widget.address.substring(0, 24) + '..'
                          : widget.address,
                      style: TextStyle(
                        color: colorTitle,
                        fontSize: width / 28.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
