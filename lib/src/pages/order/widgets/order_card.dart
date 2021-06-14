import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/services/string_service.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:get/get.dart';

class OrderCard extends StatefulWidget {
  final String title;
  final String transport;
  final String subTitle;
  final String urlToImage;
  OrderCard({
    this.title = '18110239',
    this.transport = 'Grab',
    this.subTitle = '2 ngày nữa',
    this.urlToImage =
        'https://salt.tikicdn.com/cache/w444/ts/product/04/23/5a/0cb7f8e9a9928c7cd8d0086a2df841f1.jpg',
  });
  @override
  State<StatefulWidget> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000.0),
              child: CachedNetworkImage(
                width: width * .175,
                height: width * .175,
                fit: BoxFit.cover,
                placeholder: (context, url) => PlaceHolderImage(),
                errorWidget: (context, url, error) => ErrorLoadingImage(),
                imageUrl: widget.urlToImage,
              ),
            ),
          ),
          SizedBox(width: 14.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringService().formatString(28, widget.title),
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
                      text: '${'price'.trArgs()}: ',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: width / 28.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: widget.transport,
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
                      text: 'Dự tính: ',
                      style: TextStyle(
                        color: colorTitle,
                        fontSize: width / 28.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: widget.subTitle,
                      style: TextStyle(
                        color: colorTitle,
                        fontSize: width / 26.5,
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
