import 'package:http/http.dart' as http;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'dart:convert' as convert;

class TransportService {
  Future<Map<String, dynamic>> registerTransport(
      name, description, avatar, imageVerify, phone, headquarters) async {
    var body = {
      "name": name,
      "description": description,
      "avatar": avatar,
      "imageVerify": imageVerify,
      "phone": phone,
      "headquarters": headquarters,
    };
    var response = await http.post(
      baseUrl + ApiGateway.REGISTER_TRANSPORT,
      body: body,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {}
    return {
      'status': response.statusCode,
      "name": name,
      "description": description,
      "avatar": avatar,
      "imageVerify": imageVerify,
      "phone": phone,
      "headquarters": headquarters,
    };
  }

  Future<int> assignTransport(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.ASSIGN_TRANSPORT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> updateTransport(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.UPDATE_PRICE_TYPE,
      body: body,
      headers: getHeaders(),
    );
    print(convert.jsonDecode(response.body));
    return response.statusCode;
  }

  Future<Map<String, dynamic>> updatePriceType(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.UPDATE_PRICE_TYPE,
      body: body,
      headers: getHeaders(),
    );
    print(convert.jsonDecode(response.body));
    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : null;
  }

  Future<int> createTransportSub(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.REGISTER_TRANSPORTSUB,
      body: body,
      headers: getHeaders(),
    );
    print(convert.jsonDecode(response.body));
    return response.statusCode;
  }

  Future<Map<String, dynamic>> getTransport() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_TRANSPORT,
      headers: getHeaders(),
    );
    var json = response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : convert.jsonDecode(response.body);
    json['status'] = response.statusCode;
    return json;
  }

  Future<List<dynamic>> getSubTransportByStatus(status) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_ALL_SUB_BY_STATUS + status,
      headers: getHeaders(),
    );
    var json = response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : [];
    print(json);
    return json;
  }

  Future<List<dynamic>> getAssignStaff() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_ASSIGN_STAFF,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> registerStaff(body) async {
    var response =
        await http.post(baseUrl + ApiGateway.REGISTER_STAFF, body: body);
    return response.statusCode;
  }

  Future<int> deleteTransportSub(body) async {
    var response =
        await http.post(baseUrl + ApiGateway.DELETE_TRANSPORTSUB, body: body);
    return response.statusCode;
  }

  Map<String, String> getHeaders() {
    return {
      'authorization': 'Bearer ${App.token}',
    };
  }
}
