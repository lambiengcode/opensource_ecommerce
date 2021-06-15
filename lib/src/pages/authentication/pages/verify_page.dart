import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/authentication_service.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  VerifyPage({this.email});
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  TextEditingController _otpController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String _otp = '';
  String _email = '';

  bool hidePassword = true;

  hideKeyboard() => textFieldFocus.unfocus();

  @override
  void initState() {
    super.initState();
    _email = widget.email;
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
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'verify'.trArgs(),
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
                                  context, 'Code', 'Enter your code'),
                              _buildDivider(context),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.0),
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

                              var res = await _authService.verify(_email, _otp);
                              Get.back();
                              if (res['status'] == 200) {
                                Get.offAndToNamed(Routes.ROOT);
                              } else {
                                setState(() {
                                  _otp = res['otp'];
                                  _email = res['email'];
                                  _otpController.text = res['otp'];
                                });
                                GetSnackBar snackBar = GetSnackBar(
                                  title: 'Verify Fail!',
                                  subTitle: 'Check again your code in email.',
                                );
                                snackBar.show();
                              }
                            }
                          },
                          child: Container(
                            height: 46.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: _size.width * .16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: colorTitle,
                            ),
                            child: Center(
                              child: Text(
                                'confirm'.trArgs(),
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

  Widget _buildLineInfo(context, title, valid) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 12.0, 18.0, .0),
      child: TextFormField(
        controller: _otpController,
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: colorTitle,
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
          height: 1.0,
        ),
        validator: (val) => val.trim().length != 6 ? 'Type your code' : null,
        onChanged: (val) {
          setState(() {
            _otp = val.trim();
          });
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.only(
            left: 12.0,
            bottom: 8.0,
          ),
          hintText: 'Enter the 6 digits OTP code',
          hintStyle: TextStyle(
            color: fCL,
            fontSize: _size.width / 28.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Lato',
          ),
          border: InputBorder.none,
          labelText: title,
          labelStyle: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Lato',
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
