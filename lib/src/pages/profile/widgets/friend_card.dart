import 'package:ecommerce_ec/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class FriendCard extends StatefulWidget {
  final int index;
  final bool isLast;
  final String image;
  final String fullName;
  final String address;
  final bool addFriend;
  FriendCard(
      {this.index,
      this.isLast,
      this.address,
      this.fullName,
      this.image,
      this.addFriend});
  @override
  State<StatefulWidget> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.isLast ? 4.5 : 14.5),
      decoration: widget.isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: mCH, width: .2),
              ),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: width * .15,
                width: width * .15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.fullName,
                    style: TextStyle(
                      fontSize: width / 24.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'address'.trArgs() + ': ${widget.address}',
                    style: TextStyle(
                      fontSize: width / 28.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ],
          ),
          NeumorphicButton(
            child: Icon(
              widget.addFriend ? Feather.plus : Feather.more_vertical,
              size: width / 18.0,
              color: widget.addFriend ? mC : colorBlack,
            ),
            padding: EdgeInsets.all(width / 32.0),
            style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12.0),
              ),
              depth: 20.0,
              color: widget.addFriend ? colorPrimary : mCM,
            ),
          ),
        ],
      ),
    );
  }
}
