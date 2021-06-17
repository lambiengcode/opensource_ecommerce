import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/services/string_service.dart';

class BottomSetPrice extends StatefulWidget {
  final String title;
  final data;
  BottomSetPrice({this.title, @required this.data});
  @override
  State<StatefulWidget> createState() => _BottomSetPriceState();
}

class _BottomSetPriceState extends State<BottomSetPrice> {
  final transportController = TransportController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _priceController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  String price = '';
  String priceType = 'VNĐ / Km';
  String available = 'On';

  @override
  void initState() {
    super.initState();
    priceType = widget.data['price']['km'] == '0' ? 'VNĐ / Kg' : 'VNĐ / Km';
    available = widget.data['available'] == 'ACTIVE' ? 'On' : 'Off';
    price = StringService().formatPrice(
      priceType == 'VNĐ / Km'
          ? widget.data['price']['km']
          : widget.data['price']['kg'],
    );
    _priceController.text = StringService().formatPrice(
      priceType == 'VNĐ / Km'
          ? widget.data['price']['km']
          : widget.data['price']['kg'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: height * .88,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .325),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Loại\t' + widget.title,
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontFamily: 'Lato',
                    fontSize: width / 22.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      transportController.updatePriceType(
                          widget.title,
                          price.replaceAll(',', ''),
                          (available == 'On').toString(),
                          priceType == 'VNĐ / Km' ? 'km' : 'kg');
                    }
                  },
                  child: Text(
                    'Lưu',
                    style: TextStyle(
                      color: colorPrimary,
                      fontFamily: 'Lato',
                      fontSize: width / 22.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Divider(
              thickness: .15,
              height: .15,
              color: fCL,
            ),
            SizedBox(height: 15.0),
            Text(
              '• Giá dịch vụ',
              style: TextStyle(
                color: colorPrimary,
                fontFamily: 'Lato',
                fontSize: width / 28.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              height: 75.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8.0,
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
                        validator: (val) => val.trim().length == 0
                            ? 'Đặt giá cho dịch vụ'
                            : null,
                        focusNode: _focusNode,
                        controller: _priceController,
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
                            price = val.trim();
                          });
                        },
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                          ),
                          border: InputBorder.none,
                          hintText: "Nhập giá",
                          hintStyle: TextStyle(
                            color: fCL,
                            fontSize: width / 26.0,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 16.0, right: 8.0),
                            child: Text(
                              priceType,
                              style: TextStyle(
                                color: fCL,
                                fontSize: width / 31.5,
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
                _buildButtonSwitch('VNĐ / Km', priceType == 'VNĐ / Km'),
                SizedBox(width: 16.0),
                _buildButtonSwitch('VNĐ / Kg', priceType == 'VNĐ / Kg'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              '• Trạng thái',
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
            SizedBox(height: 32.0),
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
              priceType = title;
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
            BorderRadius.circular(4.0),
          ),
          depth: isActive ? 10.0 : 5.0,
          intensity: isActive ? .8 : .65,
          color: isActive ? colorPrimary.withOpacity(.725) : mCL,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 28.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              !title.toString().contains('/') && title == 'On'
                  ? 'Hoạt động'
                  : !title.toString().contains('/') && title == 'Off'
                      ? 'Dừng hoạt động'
                      : title,
              style: TextStyle(
                color: isActive ? mCL : colorDarkGrey,
                fontSize: width / 28.5,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
