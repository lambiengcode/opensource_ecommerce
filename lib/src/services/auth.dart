import 'package:ecommerce_ec/src/app.dart';
import 'package:ecommerce_ec/src/common/routes.dart';
import 'package:ecommerce_ec/src/common/secret_key.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class AuthService {
  Future<int> loginByEmail(username, password) async {
    var body = {
      'email': username,
      'password': password,
    };
    var response = await http.post(baseUrl + LOGIN_WITH_EMAIL, body: body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body)['data']['token'];
      await prefs.setString('jwt', token);
      App.token = token;
    }
    return response.statusCode;
  }

  Future<int> register(email, password, phone, fullName) async {
    var body = {
      'email': email,
      'password': password,
      'phone': phone,
      'fullName': fullName,
    };
    var response = await http.post(baseUrl + REGISTER, body: body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    if (response.statusCode == 200) {
      var token = convert.jsonDecode(response.body)['data']['token'];
      await prefs.setString('jwt', token);
      App.token = token;
    }
    return response.statusCode;
  }

  Future<void> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = preferences;
    await prefs.setString('jwt', '');
    App.token = '';
  }
}
