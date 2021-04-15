import 'package:ecommerce_ec/src/pages/home/widget/vertical_store_card.dart';
import 'package:flutter/material.dart';

class ManageTransportList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageTransportListState();
}

class _ManageTransportListState extends State<ManageTransportList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return VerticalStoreCard();
          },
        ),
      ),
    );
  }
}
