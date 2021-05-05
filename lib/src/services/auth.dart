import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class AuthService {
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
    }
    return {
      'status': response.statusCode,
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
    if (response.statusCode == 200) {}
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
      var token = convert.jsonDecode(response.body)['data']['token'];
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
    var response =
        await http.post(baseUrl + ApiGateway.CHANGE_PASSWORD, body: body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body)['data']['token'];
      await prefs.setString('jwt', token);
      App.token = token;
    }
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
        await http.post(baseUrl + ApiGateway.FORGOT_PASSWORD, body: body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body)['data']['token'];
      await prefs.setString('jwt', token);
      App.token = token;
    }
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
}
