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
  final bool isCover;
  VerticalTransportCard({
    this.image,
    this.address,
    this.title,
    this.urlToImage,
    this.desc,
    this.isCover = true,
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
            height: _size.width * .3,
            margin: EdgeInsets.symmetric(vertical: _size.width * .01),
            padding: EdgeInsets.only(left: _size.width * .35 + 8.0, right: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12.0),
              ),
              color: mCL,
              boxShadow: [
                BoxShadow(
                  color: mCD,
                  offset: Offset(1, 1),
                  blurRadius: 1,
                ),
                BoxShadow(
                  color: mC,
                  offset: Offset(-2, -2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Text(
                  stringService.formatString(30, widget.title),
                  maxLines: 2,
                  style: TextStyle(
                    color: colorTitle,
                    fontSize: _size.width / 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.0),
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
                  (StringService().isNumeric(widget.address.replaceAll(',', ''))
                          ? 'price'.trArgs()
                          : 'address'.trArgs()) +
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
                      : 'Giới thiệu: ${widget.desc}',
                  maxLines: 2,
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 35.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 4.0),
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
                        fit: StringService()
                                .isNumeric(widget.address.replaceAll(',', ''))
                            ? BoxFit.contain
                            : widget.isCover
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
