import 'package:http/http.dart' as http;
import 'package:van_transport/src/app.dart';
import 'dart:convert' as convert;

import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';

class CouponService {
  Future<List<Map<String, dynamic>>> getCoupons() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_COUPONS,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> createCoupon(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_COUPON,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> updateCoupon(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_COUPON,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> deleteCoupon(idCategory) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_COUPON + idCategory,
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
