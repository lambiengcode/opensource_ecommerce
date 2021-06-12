import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/order/controllers/cart_client_controller.dart';

class BottomInputWeight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomInputWeightState();
}

class _BottomInputWeightState extends State<BottomInputWeight> {
  final cartController = Get.put(CartClientController());
  TextEditingController _msgController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  String weight = '';

  @override
  void dispose() {
    super.dispose();
    if (int.parse(weight.replaceAll(',', '')) > 0) {
      cartController.setWeight(weight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.5),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: mCD,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: width * .195,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                        color: mC,
                        boxShadow: [
                          BoxShadow(
                            color: mCD,
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                          BoxShadow(
                            color: mCL,
                            offset: Offset(-2, -2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        autofocus: true,
                        focusNode: _focusNode,
                        controller: _msgController,
                        onFieldSubmitted: (val) => null,
                        cursorColor: fCL,
                        cursorRadius: Radius.circular(30.0),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: colorTitle,
                          fontSize: width / 26.0,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (val) {
                          setState(() {
                            weight = val.trim();
                          });
                        },
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 14.0,
                            left: 24.0,
                          ),
                          border: InputBorder.none,
                          hintText: "Type weight of product...",
                          hintStyle: TextStyle(
                            color: fCL,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 14.0),
                            child: Text(
                              'Kg',
                              style: TextStyle(
                                color: colorTitle,
                                fontSize: width / 26.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            if (newValue.text.isEmpty) {
                              return newValue.copyWith(text: '');
                            } else if (newValue.text.compareTo(oldValue.text) !=
                                0) {
                              final int selectionIndexFromTheRight =
                                  newValue.text.length - newValue.selection.end;
                              final f = NumberFormat("#,###");
                              final number = int.parse(newValue.text
                                  .replaceAll(f.symbols.GROUP_SEP, ''));
                              final newString = f.format(number);
                              return TextEditingValue(
                                text: newString,
                                selection: TextSelection.collapsed(
                                    offset: newString.length -
                                        selectionIndexFromTheRight),
                              );
                            } else {
                              return newValue;
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            NeumorphicButton(
              onPressed: () => Get.back(),
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(30.0),
                ),
                depth: 15.0,
                intensity: 1,
                color: colorPrimary.withOpacity(.85),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 14.5,
                horizontal: 28.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.5),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: mC,
                        fontSize: width / 26.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
