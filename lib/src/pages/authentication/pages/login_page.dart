import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/authentication_service.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleView;

  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode textFieldFocus = FocusNode();
  String email = '';
  String password = '';

  bool hidePassword = true;
  bool rememberPsw = false;

  hideKeyboard() => textFieldFocus.unfocus();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
              .85,
              .0,
            ), // 10% of the width, so there are ten blinds.
            colors: [
              mC,
              mCL,
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
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
                  SizedBox(height: 12.0),
                  Container(
                    height: _size.height * .36,
                    width: _size.width,
                    margin: EdgeInsets.fromLTRB(
                      _size.width * 0.1,
                      _size.height * .088 - 16.0,
                      _size.width * 0.1,
                      16.0,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/login.png'),
                        fit: BoxFit.fitHeight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: mCL,
                          offset: Offset(-10, -10),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: mCL,
                          offset: Offset(10, 10),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _size.width * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: mC,
                            boxShadow: [
                              BoxShadow(
                                color: mCD,
                                offset: Offset(10, 10),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: mCL,
                                offset: Offset(-10, -10),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: _emailController,
                                  cursorColor: colorTitle,
                                  cursorRadius: Radius.circular(30.0),
                                  style: TextStyle(
                                    color: colorTitle,
                                    fontSize: _size.width / 26.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter,
                                  ],
                                  validator: (val) =>
                                      GetUtils.isEmail(val.trim()) == false
                                          ? 'validEmail'.trArgs()
                                          : null,
                                  onChanged: (val) => email = val.trim(),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.only(
                                      left: 12.0,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'email'.trArgs(),
                                    labelStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: .25,
                                height: .25,
                                indent: 18.0,
                                endIndent: 18.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: _passwordController,
                                  cursorColor: colorTitle,
                                  cursorRadius: Radius.circular(30.0),
                                  style: TextStyle(
                                    color: colorTitle,
                                    fontSize: _size.width / 26.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusNode: textFieldFocus,
                                  validator: (val) => val.length < 6
                                      ? 'validPsw'.trArgs()
                                      : null,
                                  onChanged: (val) => password = val.trim(),
                                  obscureText: hidePassword,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.only(
                                      left: 12.0,
                                      right: 8.0,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'password'.trArgs(),
                                    labelStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(top: 24.0),
                                      child: GestureDetector(
                                        onTap: () => Get.toNamed(
                                          Routes.FORGOTPASSWORD,
                                        ),
                                        child: Text(
                                          'forgot'.trArgs(),
                                          style: TextStyle(
                                            color: colorPrimary,
                                            fontSize: _size.width / 36.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.0),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 24.0,
                              bottom: 12.0,
                            ),
                            child: Center(
                              child: Text(
                                'goSignup'.trArgs(),
                                style: TextStyle(
                                  color: colorTitle,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  },
                                  barrierColor: Color(0x80000000),
                                  barrierDismissible: false);

                              var res = await _authService.loginByEmail(
                                  email, password);

                              Get.back();

                              if (res['status'] == 200) {
                                Get.offAndToNamed(Routes.ROOT);
                              } else if (res['status'] == 500 &&
                                  res['message'] ==
                                      'Please verify your account') {
                                Get.toNamed(Routes.VERIFY, arguments: email);
                              } else {
                                setState(() {
                                  email = res['email'];
                                  password = res['password'];
                                  _emailController.text = res['email'];
                                  _passwordController.text = res['password'];
                                });
                                GetSnackBar snackBar = GetSnackBar(
                                  title: 'Login Fail!',
                                  subTitle: 'Wrong Password',
                                );
                                snackBar.show();
                              }
                            }
                          },
                          child: Container(
                            height: 46.8,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: colorTitle,
                            ),
                            child: Center(
                              child: Text(
                                'login'.trArgs(),
                                style: TextStyle(
                                  color: colorPrimaryTextOpacity,
                                  fontSize: 12.8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text(
                                  'loginWith'.trArgs(),
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: _size.width / 32.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 52,
                              width: 52,
                              decoration: nMboxCategoryOff,
                              alignment: Alignment.center,
                              child: Icon(FontAwesomeIcons.google,
                                  size: _size.width / 20.0, color: colorHigh),
                            ),
                            SizedBox(
                              width: 28.0,
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              decoration: nMboxCategoryOff,
                              alignment: Alignment.center,
                              child: Icon(
                                FontAwesomeIcons.facebookF,
                                size: _size.width / 20.0,
                                color: Color(0xFF3B5998),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
