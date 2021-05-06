import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/auth.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback toggleView;

  SignupPage({this.toggleView});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

  bool hidePassword = true;
  bool loading = false;

  hideKeyboard() => textFieldFocus.unfocus();

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
                onPressed: () => widget.toggleView(),
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
                        SizedBox(height: .0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _size.width * 0.0),
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

                                    var res = await _authService.register(
                                      email,
                                      password,
                                      phone,
                                      fullName,
                                    );

                                    if (res['status'] == 200) {
                                      Get.toNamed(
                                        Routes.VERIFY,
                                        arguments: email,
                                      );
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
}
