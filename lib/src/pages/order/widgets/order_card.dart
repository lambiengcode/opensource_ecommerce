import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';

class OrderCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
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
                imageUrl:
                    "https://images.unsplash.com/photo-1591882351016-6f26999cea0a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTR8fHNob2V8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
              ),
            ),
          ),
          SizedBox(width: 14.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mã ĐH: Grab1621353522646',
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
                      text: 'ĐVVC: ',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: width / 28.5,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Grab',
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
                      text: '2 ngày nữa',
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
