import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:get/get.dart';

class UserCard extends StatefulWidget {
  final String fullName;
  final String phone;
  final String address;
  final String image;
  UserCard({this.fullName, this.phone, this.address, this.image});
  @override
  State<StatefulWidget> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
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
                imageUrl: widget.image,
              ),
            ),
          ),
          SizedBox(width: 14.0),
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
                      text: widget.phone,
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
