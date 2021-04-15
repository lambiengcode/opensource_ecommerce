import 'package:ecommerce_ec/src/common/style.dart';
import 'package:ecommerce_ec/src/pages/home/controllers/action_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButton extends StatefulWidget {
  final int index;
  final String title;
  final IconData icon;
  ActionButton({
    this.index,
    this.title,
    this.icon,
  });
  @override
  State<StatefulWidget> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return GetBuilder<ActionController>(
      init: ActionController(),
      builder: (_) => GestureDetector(
        onTap: () => Get.find<ActionController>().updateType(widget.index),
        child: Padding(
          padding: EdgeInsets.only(left: widget.index == 0 ? 14.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _size.width * .158,
                width: _size.width * .158,
                decoration: nMboxCategoryOff,
                alignment: Alignment.center,
                child: Icon(
                  widget.icon,
                  size: _size.width / 18.0,
                  color: widget.index == 0 ? colorPrimary : fCL,
                ),
              ),
              SizedBox(
                height: 6.5,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: _size.width / 30.0,
                  color: widget.index == 0 ? colorPrimary : fCL,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lato',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
