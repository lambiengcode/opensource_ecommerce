import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerticalTransportCard extends StatefulWidget {
  final String title;
  final File image;
  final String address;
  final String urlToImage;
  final String desc;
  VerticalTransportCard({
    this.image,
    this.address,
    this.title,
    this.urlToImage,
    this.desc,
  });
  @override
  State<StatefulWidget> createState() => _VerticalTransportCardState();
}

class _VerticalTransportCardState extends State<VerticalTransportCard> {
  StringService stringService = StringService();
  moneyToString(String money) {
    String result = '';
    int count = 0;
    for (int i = money.length - 1; i >= 0; i--) {
      if (count == 3) {
        count = 1;
        result += ',';
      } else {
        count++;
      }
      result += money[i];
    }
    String need = '';
    for (int i = result.length - 1; i >= 0; i--) {
      need += result[i];
    }
    return need;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .3,
      margin: EdgeInsets.only(bottom: 10.0, left: 12.0),
      child: Stack(
        children: [
          Container(
            height: _size.width * .28,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Expanded(
                  child: Text(
                    stringService.formatString(30, widget.title),
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: _size.width / 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Support Delivery:\t\t',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: _size.width / 32.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Standard',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: _size.width / 32.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  (widget.address.contains(',')
                          ? 'address'.trArgs()
                          : 'price'.trArgs()) +
                      ': ' +
                      stringService.formatString(25, widget.address),
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 32.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 4.5),
                Text(
                  widget.desc == ''
                      ? 'Giới thiệu: Không có'
                      : widget.desc.length < 50
                          ? 'Giới thiệu: ${widget.desc.replaceAll('\n', '. ')}'
                          : 'Giới thiệu: ${widget.desc.replaceAll('\n', '. ').substring(0, 50)}...',
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 32.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 12.0),
              ],
            ),
          ),
          Positioned(
            top: .0,
            left: .0,
            child: widget.image != null
                ? Container(
                    width: _size.width * .35,
                    height: _size.width * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                        image: FileImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: mCD,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                        BoxShadow(
                          color: mCL,
                          offset: Offset(-2, -2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: CachedNetworkImage(
                        width: _size.width * .35,
                        height: _size.width * .3,
                        fit:
                            widget.address.contains(',') || widget.address == ''
                                ? BoxFit.cover
                                : BoxFit.contain,
                        placeholder: (context, url) => PlaceHolderImage(),
                        errorWidget: (context, url, error) =>
                            ErrorLoadingImage(),
                        imageUrl: widget.urlToImage ?? '',
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
