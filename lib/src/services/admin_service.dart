import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';

class AdminService {
  // Merchant Manage
  Future<List<dynamic>> getMerchantByStatus(status) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_MERCHANT_BY_STATUS + status,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> approveMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.APPROVE_MERCHANT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> rejectMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.REJECT_MERCHANT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> cancelMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CANCEL_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  // Transport Manage
  Future<List<dynamic>> getTransportByStatus(status) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_TRANSPORT_BY_STATUS + status,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> approveTransport(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.APPROVE_TRANSPORT,
      body: body,
      headers: getHeaders(),
    );
    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> rejectTransport(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.REJECT_TRANSPORT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> cancelTransport(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CANCEL_TRANSPORT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Map<String, String> getHeaders() {
    return {
      'authorization': 'Bearer ${App.token}',
    };
  }
}
