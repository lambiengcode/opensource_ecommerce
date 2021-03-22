import 'package:delivery_hub/src/common/style.dart';
import 'package:flutter/material.dart';

class PlaceHolderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mCD,
        boxShadow: [
          BoxShadow(
              color: mCL,
              offset: Offset(3, 3),
              blurRadius: 3,
              spreadRadius: -3),
        ],
      ),
    );
  }
}
