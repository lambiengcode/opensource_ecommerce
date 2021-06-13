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

  Future<List<Map<String, String>>> getFavorites() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_FAVORITE,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
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

  Future<int> addProductToCartClient(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.ADD_PRODUCT_TO_CART_CLIENT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> updateProductToCartClient(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.UPDATE_CART_CLIENT,
      headers: getHeaders(),
      body: body,
    );
    print(convert.jsonDecode(response.body));
    return response.statusCode;
  }

  Future<int> addProductToCartMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.ADD_PRODUCT_TO_CART_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> paymentCartMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.PAYMENT_CART_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<int> deleteItemCartMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.DELETE_CART_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    print(convert.jsonDecode(response.body));
    return response.statusCode;
  }

  Future<int> deleteItemCartClient(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.DELETE_CART_CLIENT,
      headers: getHeaders(),
      body: body,
    );
    return response.statusCode;
  }

  Future<List<dynamic>> getCartMerchant() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_CART_MERCHANT,
      headers: getHeaders(),
    );
    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']['products']
        : null;
  }

  Future<dynamic> getTransportDelivery(idAddress, idMerchant) async {
    var response = await http.get(
      baseUrl +
          ApiGateway.GET_TRANSPORT_DELIVERY +
          idAddress +
          '&senderIdMerchant=$idMerchant',
      headers: getHeaders(),
    );

    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : null;
  }

  Future<List<dynamic>> getCartClient() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_CART_CLIENT,
      headers: getHeaders(),
    );

    print(convert.jsonDecode(response.body)['data']);
    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']['products']
        : null;
  }

  Map<String, String> getHeaders() {
    return {
      'authorization': 'Bearer ${App.token}',
    };
  }
}
