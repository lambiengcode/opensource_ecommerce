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
  final bool isCover;

  HorizontalStoreCard({
    @required this.address,
    @required this.desc,
    @required this.title,
    @required this.urlToImage,
    this.isCover = true,
  });
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
            width: _size.width * .4,
            margin: EdgeInsets.only(bottom: 2.5),
            padding: EdgeInsets.only(left: 6.5, right: 4.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
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
                SizedBox(height: _size.width * .2485),
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
                  (StringService().isNumeric(widget.address.replaceAll(',', ''))
                          ? 'price'.trArgs()
                          : 'address'.trArgs()) +
                      ': ' +
                      StringService().formatString(25, widget.address),
                  maxLines: 1,
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
                      : widget.desc.length < 40
                          ? 'Giới thiệu: ${widget.desc.replaceAll('\n', '. ')}'
                          : 'Giới thiệu: ${widget.desc.replaceAll('\n', '. ').substring(0, 38)}...',
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 38.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Positioned(
            top: .0,
            left: .0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.0),
                bottom: Radius.circular(2.0),
              ),
              child: CachedNetworkImage(
                width: _size.width * .4,
                height: _size.width * .23,
                fit: StringService()
                        .isNumeric(widget.address.replaceAll(',', ''))
                    ? BoxFit.contain
                    : widget.isCover
                        ? BoxFit.cover
                        : BoxFit.contain,
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
