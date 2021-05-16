import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class AuthService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Map<String, String> requestHeaders = {
    'authorization': 'Bearer ${App.token}',
  };

  Future<Map<String, dynamic>> loginByEmail(username, password) async {
    var body = {
      'email': username,
      'password': password,
    };
    var response =
        await http.post(baseUrl + ApiGateway.LOGIN_WITH_EMAIL, body: body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body)['data']['token'];
      await prefs.setString('jwt', token);
      App.token = token;
      await saveToken();
    }
    return {
      'status': response.statusCode,
      'message': response.statusCode == 500
          ? convert.jsonDecode(response.body)['message']
          : '',
      'email': username,
      'password': password,
    };
  }

  Future<Map<String, dynamic>> register(
      email, password, phone, fullName) async {
    var body = {
      'email': email,
      'password': password,
      'phone': phone,
      'fullName': fullName,
    };
    var response = await http.post(baseUrl + ApiGateway.REGISTER, body: body);
    return {
      'status': response.statusCode,
      'email': email,
      'password': password,
      'phone': phone,
      'fullName': fullName,
    };
  }

  Future<Map<String, dynamic>> verify(email, otp) async {
    var body = {
      'email': email,
      'otp': otp.toString(),
    };
    var response = await http.post(baseUrl + ApiGateway.VERIFY, body: body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body)['data'];
      await prefs.setString('jwt', token);
      App.token = token;
    }
    return {
      'status': response.statusCode,
      'email': email,
      'otp': otp,
    };
  }

  Future<Map<String, dynamic>> changePassword(oldPassword, newPassword) async {
    var body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
    var response = await http.put(
      baseUrl + ApiGateway.CHANGE_PASSWORD,
      body: body,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {}
    return {
      'status': response.statusCode,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  Future<Map<String, dynamic>> forgotPassword(email) async {
    var body = {
      'email': email,
    };
    var response =
        await http.put(baseUrl + ApiGateway.FORGOT_PASSWORD, body: body);
    return {
      'status': response.statusCode,
      'email': email,
    };
  }

  Future<void> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    await prefs.setString('jwt', '');
    App.token = '';
  }

  Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    String appVersion;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
        appVersion = "1.0.0";
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
        appVersion = "1.0.0";
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [deviceName, deviceVersion, identifier, appVersion];
  }

  _saveDeviceToken() async {
    String fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      var infoDevice = await getDeviceDetails();
      print(infoDevice);
    }
  }

  Future<void> saveToken() async {
    await _saveDeviceToken();
    _fcm.requestNotificationPermissions(const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false));
  }
}
