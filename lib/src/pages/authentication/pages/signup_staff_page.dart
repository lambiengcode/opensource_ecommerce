import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/services/authentication_service.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class SignupStaffPage extends StatefulWidget {
  @override
  _SignupStaffPageState createState() => _SignupStaffPageState();
}

class _SignupStaffPageState extends State<SignupStaffPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPswController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String fullName = '';
  String phone = '';
  String email = '';
  String password = '';
  File _image = null;

  bool hidePassword = true;
  bool loading = false;

  hideKeyboard() => textFieldFocus.unfocus();

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

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: .0,
              backgroundColor: mC,
              brightness: Brightness.light,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Feather.arrow_left,
                  color: colorTitle,
                  size: _size.width / 15.0,
                ),
              ),
              title: Text(
                'getStarted'.trArgs(),
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
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => showImageBottomSheet(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: _size.width * .31,
                                          width: _size.width * .31,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: colorPrimary,
                                              width: 3.0,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Container(
                                            height: _size.width * .28,
                                            width: _size.width * .28,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: mC,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: mCL,
                                                  offset: Offset(3, 3),
                                                  blurRadius: 3,
                                                  spreadRadius: -3,
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://avatars.githubusercontent.com/u/60530946?s=460&u=e342f079ed3571122e21b42eedd0ae251a9d91ce&v=4'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 12.0),
                                    _buildLineInfo(
                                      context,
                                      'phone'.trArgs(),
                                      'validPhone'.trArgs(),
                                      _phoneController,
                                    ),
                                    _buildDivider(context),
                                    _buildLineInfo(
                                      context,
                                      'fullName'.trArgs(),
                                      'validFullName'.trArgs(),
                                      _fullNameController,
                                    ),
                                    _buildDivider(context),
                                    _buildLineInfo(
                                      context,
                                      'email'.trArgs(),
                                      'validEmail'.trArgs(),
                                      _emailController,
                                    ),
                                    _buildDivider(context),
                                    _buildLineInfo(
                                      context,
                                      'password'.trArgs(),
                                      'validPsw'.trArgs(),
                                      _passwordController,
                                    ),
                                    _buildDivider(context),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          14.0, 24.0, 18.0, 4.0),
                                      child: TextFormField(
                                        controller: _confirmPswController,
                                        cursorColor: colorTitle,
                                        cursorRadius: Radius.circular(30.0),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: _size.width / 26.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        validator: (val) =>
                                            val.trim() != password
                                                ? 'validConfirmPsw'.trArgs()
                                                : null,
                                        obscureText: hidePassword,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          contentPadding: EdgeInsets.only(
                                            left: 12.0,
                                          ),
                                          border: InputBorder.none,
                                          labelText: 'confirmPsw'.trArgs(),
                                          labelStyle: TextStyle(
                                            color: colorTitle,
                                            fontSize: _size.width / 26.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
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
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  var res = await _authService.register(
                                    email,
                                    password,
                                    phone,
                                    fullName,
                                  );

                                  if (res['status'] == 200) {
                                    Get.offAndToNamed('/root');
                                  } else {
                                    setState(() {
                                      loading = false;
                                      email = res['email'];
                                      password = res['password'];
                                      fullName = res['fullName'];
                                      phone = res['phone'];
                                      _confirmPswController.text =
                                          res['password'];
                                      _emailController.text = res['email'];
                                      _passwordController.text =
                                          res['password'];
                                      _phoneController.text = res['phone'];
                                      _fullNameController.text =
                                          res['fullName'];
                                    });
                                    GetSnackBar snackBar = GetSnackBar(
                                      title: 'Signup Fail!',
                                      subTitle: 'Email exists, try again!',
                                    );
                                    snackBar.show();
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
                                      'createAccount'.trArgs(),
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
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
      child: TextFormField(
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
          } else if (title == 'email'.trArgs()) {
            return GetUtils.isEmail(val.trim()) ? null : valid;
          } else {
            return val.trim().length < 6 ? valid : null;
          }
        },
        onChanged: (val) {
          setState(() {
            if (title == 'phone'.trArgs()) {
              phone = val.trim();
            } else if (title == 'fullName'.trArgs()) {
              fullName = val.trim();
            } else if (title == 'email'.trArgs()) {
              email = val.trim();
            } else {
              password = val.trim();
            }
          });
        },
        inputFormatters: [
          title == 'Phone Number' || title == 'Số Điện Thoại'
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        obscureText: title == 'Password' || title == 'Mật khẩu' ? true : false,
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
        maxHeight: 450.0,
        maxWidth: 450.0,
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
