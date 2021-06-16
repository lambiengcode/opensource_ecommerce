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

  Future<List<dynamic>> getFavorites() async {
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
    return response.statusCode;
  }

  Future<int> updateProductToCartMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.UPDATE_CART_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
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

  Future<dynamic> paymentCartMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.PAYMENT_CART_MERCHANT,
      headers: getHeaders(),
      body: body,
    );
    return response;
  }

  Future<dynamic> paymentCartClient(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.PAYMENT_CART_CLIENT,
      headers: getHeaders(),
      body: body,
    );

    return response;
  }

  Future<int> deleteItemCartMerchant(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.DELETE_CART_MERCHANT,
      headers: getHeaders(),
      body: body,
    );

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

  Future<dynamic> getTransportDeliveryClient(idAddress, lat, lng) async {
    var response = await http.get(
      baseUrl +
          ApiGateway.GET_TRANSPORT_DELIVERY_CLIENT +
          idAddress +
          '&receiverLat=$lat&receiverLng=$lng',
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

    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']['products']
        : null;
  }

  Future<List<dynamic>> getOrderByStatus(status) async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_ORDER_BY_STATUS + status,
      headers: getHeaders(),
    );

    return response.statusCode == 200
        ? convert.jsonDecode(response.body)['data']
        : [];
  }

  Future<int> cancelOrder(idPackage) async {
    var response = await http.get(
      baseUrl + ApiGateway.USER_CANCEL_ORDER + idPackage,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> receiveOrder(idPackage) async {
    var response = await http.get(
      baseUrl + ApiGateway.USER_RECEIVE_ORDER + idPackage,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Map<String, String> getHeaders() {
    return {
      'authorization': 'Bearer ${App.token}',
    };
  }
}
