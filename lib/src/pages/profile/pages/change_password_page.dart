import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  String _oldPassword = '';
  String _newPassword = '';

  void changePassword(String oldPassword, String newPassword) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ${App.token}',
    };
    var response = await http.put(
      '$baseUrl/auth/change-password',
      headers: requestHeaders,
      body: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
    );
    if (response.statusCode == 200) {
      Get.back();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
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
            onPressed: () {
              if (_formKey.currentState.validate()) {
                changePassword(_oldPassword, _newPassword);
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
              ),
              _buildDivider(context),
              _buildLineInfo(
                context,
                'newPsw'.trArgs(),
                'validPsw'.trArgs(),
              ),
              _buildDivider(context),
              _buildLineInfo(
                context,
                'confirmPsw'.trArgs(),
                'validConfirmPsw'.trArgs(),
              ),
              _buildDivider(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
      child: TextFormField(
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: colorTitle,
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          if (title == 'confirmpsw'.trArgs()) {
            return val.trim() != _newPassword ? valid : null;
          } else {
            return val.trim().length < 6 ? valid : null;
          }
        },
        onChanged: (val) {
          setState(() {
            if (title == 'currentpsw'.trArgs()) {
              _oldPassword = val.trim();
            } else if (title == 'newpsw'.trArgs()) {
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
