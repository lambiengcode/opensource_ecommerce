import 'package:cached_network_image/cached_network_image.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalStoreCard extends StatefulWidget {
  final String title;
  final String address;
  final String urlToImage;
  final String desc;

  HorizontalStoreCard({this.address, this.desc, this.title, this.urlToImage});
  @override
  State<StatefulWidget> createState() => _HorizontalStoreCardState();
}

class _HorizontalStoreCardState extends State<HorizontalStoreCard> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * .4,
      margin: EdgeInsets.only(right: 6.0),
      child: Stack(
        children: [
          Container(
            width: _size.width * .38,
            margin: EdgeInsets.only(left: _size.width * .01, bottom: 4.0),
            padding: EdgeInsets.only(left: 6.5, right: 4.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: mC,
              boxShadow: [
                BoxShadow(
                  color: mCD,
                  offset: Offset(5, 5),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: mCL,
                  offset: Offset(-5, -5),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: _size.width * .28),
                Text(
                  StringService().formatString(25, widget.title),
                  maxLines: 1,
                  style: TextStyle(
                    color: colorTitle,
                    fontSize: _size.width / 36.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  (widget.address.contains('000')
                          ? 'price'.trArgs()
                          : 'address'.trArgs()) +
                      ': ' +
                      StringService().formatString(25, widget.address),
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: _size.width / 36.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  widget.desc == ''
                      ? 'Giới thiệu: Không có'
                      : widget.desc.length < 36.5
                          ? 'Giới thiệu: ${widget.desc.replaceAll('\n', '. ')}'
                          : 'Giới thiệu: ${widget.desc.replaceAll('\n', '. ').substring(0, 30)}...',
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 38.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                  maxLines: 1,
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
                width: _size.width * .40,
                height: _size.width * .26,
                fit: BoxFit.cover,
                placeholder: (context, url) => PlaceHolderImage(),
                errorWidget: (context, url, error) => ErrorLoadingImage(),
                imageUrl: widget.urlToImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
