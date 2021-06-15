import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';

class EditGroupPage extends StatefulWidget {
  final groupProductInfo;
  EditGroupPage({this.groupProductInfo});
  @override
  State<StatefulWidget> createState() => _EditGroupPageState();
}

class _EditGroupPageState extends State<EditGroupPage> {
  final merchantController = Get.put(MerchantController());
  String _title;
  String _desc;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _title = widget.groupProductInfo['name'];
    _desc = widget.groupProductInfo['description'];
    titleController.text = widget.groupProductInfo['name'];
    descController.text = widget.groupProductInfo['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: .0,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 15.0,
          ),
        ),
        title: Text(
          'Create Product',
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              merchantController.updateGroupProduct(
                widget.groupProductInfo['FK_merchant'],
                widget.groupProductInfo['_id'],
                _title,
                _desc,
              );
            },
            icon: Icon(
              Feather.check,
              color: colorPrimary,
              size: width / 16.0,
            ),
          ),
        ],
      ),
      body: Container(
        color: mC,
        child: Column(
          children: [
            SizedBox(height: 12.0),
            _buildLineInfo(context, 'groupName'.trArgs(), '', titleController),
            _buildDivider(context),
            _buildLineInfo(context, 'description'.trArgs(), '', descController),
            _buildDivider(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 14.0, 4.0),
      child: TextFormField(
        controller: controller,
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: colorTitle,
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) => val.trim().length == 0 ? 'Input value here' : null,
        onChanged: (val) {
          setState(() {
            if (title == 'groupName'.trArgs()) {
              _title = val.trim();
            } else {
              _desc = val.trim();
            }
          });
        },
        inputFormatters: title == 'Price - VNĐ'
            ? [
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction((oldValue, newValue) {
                  if (newValue.text.isEmpty) {
                    return newValue.copyWith(text: '');
                  } else if (newValue.text.compareTo(oldValue.text) != 0) {
                    final int selectionIndexFromTheRight =
                        newValue.text.length - newValue.selection.end;
                    final f = NumberFormat("#,###");
                    final number = int.parse(
                        newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
                    final newString = f.format(number);
                    return TextEditingValue(
                      text: newString,
                      selection: TextSelection.collapsed(
                          offset:
                              newString.length - selectionIndexFromTheRight),
                    );
                  } else {
                    return newValue;
                  }
                })
              ]
            : [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.only(
            left: 12.0,
          ),
          border: InputBorder.none,
          labelText: title,
          labelStyle: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(context) {
    return Divider(
      color: Colors.grey.shade400,
      thickness: .25,
      height: .25,
      indent: 25.0,
      endIndent: 25.0,
    );
  }
}
