import 'package:http/http.dart' as http;
import 'package:van_transport/src/common/routes.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/secret_key.dart';

class UserService {
  Map<String, String> requestHeaders = {
    'authorization': 'Bearer ${App.token}',
  };

  Future<Map<String, dynamic>> getProfile() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_PROFILE,
      headers: requestHeaders,
    );

    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> updateProfile(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_PROFILE,
      headers: requestHeaders,
      body: body,
    );
    return response.statusCode;
  }

  Future<int> addAddress(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.ADD_ADDRESS,
      headers: requestHeaders,
      body: body,
    );
    return response.statusCode;
  }

  Future<int> updateAddress(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_ADDRESS,
      headers: requestHeaders,
      body: body,
    );
    return response.statusCode;
  }

  Future<int> deleteAddress(id) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_ADDRESS + id,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<String> buyPoint(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.BUY_POINT,
      headers: requestHeaders,
      body: body,
    );
    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : null;
  }
}
