import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/services/authentication_service.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _oldPassword = '';
  String _newPassword = '';

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
          'changePsw'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
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
                var res = await _authService.changePassword(
                    _oldPassword, _newPassword);
                Get.back();
                if (res['status'] == 200) {
                  Get.back();
                  GetSnackBar snackBar = GetSnackBar(
                    title: 'Successfully!',
                    subTitle: 'Change password successfully!',
                  );
                  snackBar.show();
                } else {
                  setState(() {
                    _oldPassword = res['oldPassword'];
                    _newPassword = res['newPassword'];
                    _oldPasswordController.text = res['oldPassword'];
                    _newPasswordController.text = res['newPassword'];
                    _confirmPasswordController.text = res['newPassword'];
                  });
                  GetSnackBar snackBar = GetSnackBar(
                    title: 'Change Password Fail!',
                    subTitle: 'Wrong old password, try again.',
                  );
                  snackBar.show();
                }
              }
            },
            icon: Icon(
              Feather.check,
              color: colorPrimary,
              size: _size.width / 16.0,
            ),
          )
        ],
      ),
      body: Container(
        color: mC,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 12.0),
              _buildLineInfo(
                context,
                'currentPsw'.trArgs(),
                'validPsw'.trArgs(),
                _oldPasswordController,
              ),
              _buildDivider(context),
              _buildLineInfo(
                context,
                'newPsw'.trArgs(),
                'validPsw'.trArgs(),
                _newPasswordController,
              ),
              _buildDivider(context),
              _buildLineInfo(
                context,
                'confirmPsw'.trArgs(),
                'validConfirmPsw'.trArgs(),
                _confirmPasswordController,
              ),
              _buildDivider(context),
            ],
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
          if (title == 'confirmPsw'.trArgs()) {
            return val.trim() != _newPassword ? valid : null;
          } else {
            return val.trim().length < 6 ? valid : null;
          }
        },
        onChanged: (val) {
          setState(() {
            if (title == 'currentPsw'.trArgs()) {
              _oldPassword = val.trim();
            } else if (title == 'newPsw'.trArgs()) {
              _newPassword = val.trim();
            }
          });
        },
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        obscureText: true,
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
