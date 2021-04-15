import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/widgets/error_loading_image.dart';
import 'package:ecommerce_ec/src/widgets/place_holder_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProductOrderCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductOrderCardState();
}

class _ProductOrderCardState extends State<ProductOrderCard> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width * .3,
      margin: EdgeInsets.only(bottom: 8.0, left: 12.0),
      child: Stack(
        children: [
          Container(
            height: _size.width * .295,
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
                        width: _size.width * .2,
                        height: _size.width * .2,
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
                            width: _size.width * .175,
                            height: _size.width * .175,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => PlaceHolderImage(),
                            errorWidget: (context, url, error) =>
                                ErrorLoadingImage(),
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
                            'Nike Air Max 200',
                            style: TextStyle(
                              color: colorTitle,
                              fontSize: width / 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Weight:\t\t',
                                  style: TextStyle(
                                    color: colorDarkGrey,
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '15 ',
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Kg',
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
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
                                  text: 'Type:\t\t',
                                  style: TextStyle(
                                    color: colorDarkGrey,
                                    fontSize: width / 26.0,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Basic',
                                  style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: width / 26.0,
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
        ],
      ),
    );
  }
}
