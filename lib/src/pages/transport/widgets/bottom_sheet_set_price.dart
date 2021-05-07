import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/common/style.dart';

class BottomSetPrice extends StatefulWidget {
  final String title;
  BottomSetPrice({this.title});
  @override
  State<StatefulWidget> createState() => _BottomSetPriceState();
}

class _BottomSetPriceState extends State<BottomSetPrice> {
  TextEditingController _msgController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  String price = 'VNĐ / Km';
  String available = 'Off';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
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
            SizedBox(height: 24.0),
            Text(
              widget.title + '\tService',
              style: TextStyle(
                color: colorDarkGrey,
                fontFamily: 'Lato',
                fontSize: width / 22.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '• Setting Price',
              style: TextStyle(
                color: colorPrimary,
                fontFamily: 'Lato',
                fontSize: width / 28.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              height: width * .18,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
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
                        onChanged: (val) {},
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 14.0,
                            left: 24.0,
                          ),
                          border: InputBorder.none,
                          hintText: "Type price...",
                          hintStyle: TextStyle(
                            color: fCL,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 16.0, right: 8.0),
                            child: Text(
                              price,
                              style: TextStyle(
                                color: colorDarkGrey,
                                fontSize: width / 30.0,
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
            SizedBox(height: 2.5),
            Row(
              children: [
                _buildButtonSwitch('VNĐ / Km', price == 'VNĐ / Km'),
                SizedBox(width: 16.0),
                _buildButtonSwitch('VNĐ / Kg', price == 'VNĐ / Kg'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              '• Available',
              style: TextStyle(
                color: colorPrimary,
                fontFamily: 'Lato',
                fontSize: width / 28.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                _buildButtonSwitch('On', available == 'On'),
                SizedBox(width: 16.0),
                _buildButtonSwitch('Off', available == 'Off'),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(
              thickness: .2,
              height: .2,
              color: colorDarkGrey,
            ),
            SizedBox(height: 16.0),
            NeumorphicButton(
              onPressed: () => Get.back(),
              duration: Duration(milliseconds: 200),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(6.0),
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
                  Text(
                    'confirm'.trArgs(),
                    style: TextStyle(
                      color: mC,
                      fontSize: width / 26.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.0),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSwitch(title, isActive) {
    return Expanded(
      child: NeumorphicButton(
        onPressed: () {
          if (title.toString().contains('VNĐ')) {
            setState(() {
              price = title;
            });
          } else {
            setState(() {
              available = title;
            });
          }
        },
        duration: Duration(milliseconds: 200),
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(6.0),
          ),
          depth: 5.0,
          intensity: .65,
          color: isActive ? colorPrimary.withOpacity(.8) : mCL,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 28.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? mCL : colorDarkGrey,
                fontSize: width / 28.5,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
