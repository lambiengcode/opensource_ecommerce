import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/routes/app_pages.dart';

class InputInfoReceiverPage extends StatefulWidget {
  @override
  _InputInfoReceiverPageState createState() => _InputInfoReceiverPageState();
}

class _InputInfoReceiverPageState extends State<InputInfoReceiverPage> {
  final pickAddressController = Get.put(PickAddressController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String fullName = '';
  String phone = '';
  String _title = '';
  String desc = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    pickAddressController.initialFormInput();
    fullName = pickAddressController.infoReceiver.fullName;
    phone = pickAddressController.infoReceiver.phone;

    _title = pickAddressController.infoReceiver.title;
    desc = pickAddressController.infoReceiver.description;
    address = pickAddressController.infoReceiver.address;
    _phoneController.text = pickAddressController.infoReceiver.phone;
    _titleController.text = pickAddressController.infoReceiver.title;
    _descController.text = pickAddressController.infoReceiver.description;
    _fullNameController.text = pickAddressController.infoReceiver.fullName;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: .0,
        backgroundColor: mC,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () {
            Get.back();
            // pickAddressController.disposeFormInput();
          },
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'Thông tin người nhận',
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        color: mC,
        child: Form(
          key: _formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: .0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _size.width * 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: mC,
                            boxShadow: [
                              BoxShadow(
                                color: mCL,
                                offset: Offset(-10, -10),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 12.0),
                              _buildLineInfo(
                                context,
                                'fullName'.trArgs(),
                                'validFullName'.trArgs(),
                                _fullNameController,
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'phone'.trArgs(),
                                'validPhone'.trArgs(),
                                _phoneController,
                              ),
                              _buildDivider(context),
                              GetBuilder<PickAddressController>(
                                builder: (_) => _buildLineInfo(
                                  context,
                                  'address'.trArgs(),
                                  'validAddress'.trArgs(),
                                  _.addressController,
                                ),
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'title'.trArgs(),
                                'Nhập tiêu đề đơn hàng',
                                _titleController,
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'description'.trArgs(),
                                'Nhập mô tả đơn hàng',
                                _descController,
                              ),
                              _buildDivider(context),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              pickAddressController.saveInfoReceiver(
                                fullName,
                                phone,
                                _title,
                                desc,
                              );
                            }
                          },
                          child: Container(
                            height: 46.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: _size.width * .12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: colorTitle,
                            ),
                            child: Center(
                              child: Text(
                                'Lưu thông tin',
                                style: TextStyle(
                                  color: colorPrimaryTextOpacity,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 36.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (title == 'address'.trArgs()) {
          Get.toNamed(
            Routes.ADDRESS,
            arguments: {
              'pickMode': PICK_ON,
              'isFrom': false,
            },
          );
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
        child: TextFormField(
          onTap: () {
            if (title == 'address'.trArgs()) {
              Get.toNamed(
                Routes.ADDRESS,
                arguments: {
                  'pickMode': PICK_ON,
                  'isFrom': false,
                },
              );
            }
          },
          controller: controller,
          cursorColor: colorTitle,
          cursorRadius: Radius.circular(30.0),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w500,
          ),
          validator: (val) {
            if (title == 'phone'.trArgs()) {
              return GetUtils.isPhoneNumber(val.trim()) ? null : valid;
            } else if (title == 'fullName'.trArgs()) {
              return val.trim().length == 0 ? valid : null;
            } else if (title == 'address'.trArgs()) {
              return val.trim().length == 0 ? valid : null;
            } else {
              return val.trim().length == 0 ? valid : null;
            }
          },
          onChanged: (val) {
            setState(() {
              if (title == 'phone'.trArgs()) {
                phone = val.trim();
              } else if (title == 'fullName'.trArgs()) {
                fullName = val.trim();
              } else if (title == 'description'.trArgs()) {
                desc = val.trim();
              } else {
                _title = val.trim();
              }
            });
          },
          inputFormatters: [
            title == 'phone'.trArgs()
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter,
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
