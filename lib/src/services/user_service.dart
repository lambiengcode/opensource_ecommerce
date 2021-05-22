import 'package:http/http.dart' as http;
import 'package:van_transport/src/common/routes.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/secret_key.dart';

class UserService {
  Future<Map<String, dynamic>> getProfile() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_PROFILE,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> updateProfile(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_PROFILE,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> addAddress(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.ADD_ADDRESS,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> updateAddress(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_ADDRESS,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> deleteAddress(id) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_ADDRESS + id,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> favorite(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.FAVORITE,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> getFavorites() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_FAVORITE,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<String> buyPoint(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.BUY_POINT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : null;
  }

  Map<String, String> getHeaders() {
    return {
      'authorization': 'Bearer ${App.token}',
    };
  }
}
