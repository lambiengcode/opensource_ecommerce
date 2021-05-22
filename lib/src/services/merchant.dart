import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';

class MerchantService {
  Map<String, String> requestHeaders = {
    'authorization': 'Bearer ${App.token}',
  };

  Future<Map<String, dynamic>> getMerchant() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_MERCHANT,
      headers: requestHeaders,
    );
    var json = response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : convert.jsonDecode(response.body);
    json['status'] = response.statusCode;
    return json;
  }

  Future<List<dynamic>> getGroupProduct(idMerchant) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_GROUP_PRODUCT + idMerchant,
      headers: requestHeaders,
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<List<dynamic>> getProductByGroup(idGroup) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_PRODUCT_BY_GROUP + idGroup,
      headers: requestHeaders,
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<List<dynamic>> getProductByMerchant(idMerchant) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_PRODUCT_BY_MERCHANT + idMerchant,
      headers: requestHeaders,
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> createMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_MERCHANT,
      body: body,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> createGroupProduct(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_GROUP_PRODUCT,
      body: body,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> createProduct(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_PRODUCT,
      body: body,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> updateMerchant(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_MERCHANT,
      body: body,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> updateGroupProduct(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_GROUP_PRODUCT,
      body: body,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> updateProduct(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_PRODUCT,
      body: body,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> deleteGroupProduct(idGroup) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_GROUP_PRODUCT + idGroup,
      headers: requestHeaders,
    );
    return response.statusCode;
  }

  Future<int> deleteProduct(idProduct) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_PRODUCT + idProduct,
      headers: requestHeaders,
    );
    return response.statusCode;
  }
}
