import 'dart:io';
import 'dart:ui';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';
import 'package:van_transport/src/services/storage_service.dart';
import 'package:van_transport/src/widgets/loading_page.dart';

class MyProfilePage extends StatefulWidget {
  final String urlToImage;
  final String fullName;
  final String phoneNumber;
  final String email;
  final DateTime createdAt;
  final String point;
  final String role;

  MyProfilePage({
    this.urlToImage,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.createdAt,
    this.point,
    this.role,
  });
  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
  File _image;
  String _fullName;
  String _phone;

  String code = '';

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void showImageBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _chooseImage(context);
      },
    );
  }

  moneyToString(String money) {
    String result = '';
    int count = 0;
    for (int i = money.length - 1; i >= 0; i--) {
      if (count == 3) {
        count = 1;
        result += ',';
      } else {
        count++;
      }
      result += money[i];
    }
    String need = '';
    for (int i = result.length - 1; i >= 0; i--) {
      need += result[i];
    }
    return need;
  }

  @override
  void initState() {
    super.initState();
    _fullName = widget.fullName;
    _phone = widget.phoneNumber;
    _fullNameController.text = widget.fullName;
    _phoneController.text = widget.phoneNumber;
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mC,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'myInfo'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    },
                    barrierColor: Color(0x80000000),
                    barrierDismissible: false);
                if (_image != null) {
                  StorageService storageService = StorageService();
                  String urlToImage =
                      await storageService.uploadImage(_image, widget.email);
                  profileController.updateProfile(
                    _fullName,
                    _phone,
                    urlToImage,
                  );
                  Get.back();
                } else {
                  Get.back();
                  profileController.updateProfile(
                    _fullName,
                    _phone,
                    widget.urlToImage,
                  );
                }
              }
            },
            icon: Icon(
              Feather.check,
              color: colorPrimary,
              size: _size.width / 15.0,
            ),
          ),
        ],
      ),
      body: Container(
        color: mC,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8.0),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    return true;
                  },
                  child: _buildFirstPage(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPage(context) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        _buildDivider(context),
        SizedBox(height: 24.0),
        _buildImageInfo(context, widget.urlToImage),
        SizedBox(height: 16.0),
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
          'validFullName'.trArgs(),
          _phoneController,
        ),
        _buildDivider(context),
        _buildLineInfo(
          context,
          'email'.trArgs(),
          'validFullName'.trArgs(),
          _emailController,
        ),
        _buildDivider(context),
        // Expanded(
        //   child: Center(
        //     child: QrImage(
        //       data: widget.phoneNumber,
        //       version: QrVersions.auto,
        //       size: 110.0,
        //       gapless: false,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildImageInfo(context, urlToImage) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => showImageBottomSheet(),
            child: Container(
              height: _size.width * .26,
              width: _size.width * .26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mCD,
                boxShadow: [
                  BoxShadow(
                      color: mCL,
                      offset: Offset(3, 3),
                      blurRadius: 3,
                      spreadRadius: -3),
                ],
                image: _image == null && urlToImage == null
                    ? null
                    : DecorationImage(
                        image: _image == null
                            ? NetworkImage(urlToImage)
                            : FileImage(_image),
                        fit: BoxFit.cover,
                      ),
              ),
              child: _image == null && urlToImage == null
                  ? Icon(
                      Feather.camera,
                      color: colorTitle,
                      size: _size.width / 15.0,
                    )
                  : Text(''),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fullName,
                  style: TextStyle(
                    color: colorTitle,
                    fontSize: _size.width / 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Role: ' + widget.role,
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 26.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  '${'joinDate'.trArgs()}: ${DateFormat('dd/MM/yyyy').format(widget.createdAt)}',
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 26.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  '${'point'.trArgs()}: ${widget.point}',
                  style: TextStyle(
                    color: fCD,
                    fontSize: _size.width / 26.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
      child: TextFormField(
        controller: controller,
        enabled: title == 'fullName'.trArgs() || title == 'phone'.trArgs(),
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: colorTitle,
          fontSize: _size.width / 24.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          if (title == 'fullName'.trArgs()) {
            return val.trim().length == 0 ? valid : null;
          } else if (title == 'phone'.trArgs()) {
            return GetUtils.isPhoneNumber(val.trim()) ? null : valid;
          } else {
            return null;
          }
        },
        onChanged: (val) {
          setState(() {
            if (title == 'fullName'.trArgs()) {
              _fullName = val.trim();
            } else {
              _phone = val.trim();
            }
          });
        },
        inputFormatters: [
          title == 'Phone Number' || title == 'ID Number'
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        obscureText: title == 'Password' ? true : false,
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

  Widget _chooseImage(context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            30.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
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
            _buildAction(context, 'capture'.trArgs(), Feather.camera),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(context, 'pickPhoto'.trArgs(), Feather.image),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon) {
    final _size = MediaQuery.of(context).size;

    Future<void> _pickImage(ImageSource source) async {
      File selected = await ImagePicker.pickImage(
        source: source,
        maxHeight: 400.0,
        maxWidth: 400.0,
      );
      if (selected != null) {
        setState(() {
          _image = selected;
        });
        Get.back();
      }
    }

    return GestureDetector(
      onTap: () {
        switch (title) {
          // English
          case 'Take a Photo':
            _pickImage(ImageSource.camera);
            break;
          case 'Choose from Album':
            _pickImage(ImageSource.gallery);
            break;

          // Vietnamese
          case 'Chụp ảnh':
            _pickImage(ImageSource.camera);
            break;
          case 'Chọn ảnh từ Album':
            _pickImage(ImageSource.gallery);
            break;

          default:
            break;
        }
      },
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: _size.width / 16.0,
                  color: Colors.grey.shade800,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _size.width / 22.5,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
