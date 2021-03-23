import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_hub/src/common/style.dart';
import 'package:delivery_hub/src/widgets/error_loading_image.dart';
import 'package:delivery_hub/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class VerticalStoreCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerticalStoreCardState();
}

class _VerticalStoreCardState extends State<VerticalStoreCard> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .28,
      margin: EdgeInsets.only(bottom: 10.0, left: 12.0),
      child: Stack(
        children: [
          Container(
            height: _size.width * .26,
            margin: EdgeInsets.only(top: _size.width * .01),
            padding: EdgeInsets.only(left: _size.width * .35 + 8.0, right: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12.0),
              ),
              color: mC,
              boxShadow: [
                BoxShadow(
                  color: mCD,
                  offset: Offset(5, 5),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: mCL,
                  offset: Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Highlands Coffee',
                      style: TextStyle(
                        color: colorTitle,
                        fontSize: _size.width / 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.amber.shade600,
                          size: _size.width / 32.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.2),
                          child: Text(
                            '4.6',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: _size.width / 32.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'delivery'.trArgs()} 30 ${'min'.trArgs()}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: _size.width / 32.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${'opens'.trArgs()} 9 am',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: _size.width / 36.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'startfrom'.trArgs()} \$4',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: _size.width / 32.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${'closes'.trArgs()} 10 pm',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: _size.width / 36.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Coffee',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: _size.width / 36.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Fastfood',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: _size.width / 36.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Breakfast',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: _size.width / 36.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: .0,
            left: .0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                width: _size.width * .35,
                height: _size.width * .28,
                fit: BoxFit.cover,
                placeholder: (context, url) => PlaceHolderImage(),
                errorWidget: (context, url, error) => ErrorLoadingImage(),
                imageUrl:
                    "https://www.highlandscoffee.com.vn/vnt_upload/weblink/HCO-7605-FESTIVE-2020-WEB-FB-2000X639_1.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
