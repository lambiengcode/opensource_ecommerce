import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';

class MerchantService {
  Future<Map<String, dynamic>> getMerchant() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_MERCHANT,
      headers: getHeaders(),
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
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<List<dynamic>> getProductByGroup(idGroup, page) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_PRODUCT_BY_GROUP + idGroup + '&page=$page',
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<List<dynamic>> getProductByMerchant(idMerchant, page) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_PRODUCT_BY_MERCHANT + idMerchant + '&page=$page',
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> createMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_MERCHANT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> createGroupProduct(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_GROUP_PRODUCT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> createProduct(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_PRODUCT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> updateMerchant(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_MERCHANT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> updateGroupProduct(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_GROUP_PRODUCT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> updateProduct(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_PRODUCT,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> deleteGroupProduct(idGroup) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_GROUP_PRODUCT + idGroup,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> deleteProduct(idProduct) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_PRODUCT + idProduct,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  // For Admin
  Future<int> rejectMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.REJECT_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> cancelMerhcant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CANCEL_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> approveMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.APPROVE_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> getMerchantByState(status) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_MERCHANT_BY_STATUS + status,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<List<dynamic>> getProduct(page) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_ALL_PRODUCT + page,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<Map<String, dynamic>> getMerchantById(idMerchant) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_MERCHANT_BY_ID + idMerchant,
      headers: getHeaders(),
    );
    print(idMerchant);
    print(convert.jsonDecode(response.body)['data']);
    return convert.jsonDecode(response.body)['data'];
  }

  Future<List<dynamic>> getOrderByStatus(status) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_ORDER_BY_STATUS_MERCHANT + status,
      headers: getHeaders(),
    );

    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : [];
  }

  Map<String, String> getHeaders() {
    return {
      'authorization': 'Bearer ${App.token}',
    };
  }
}
