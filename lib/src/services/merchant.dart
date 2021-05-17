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

  Future<int> createGroupProduct(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_GROUP_PRODUCT,
      body: body,
      headers: requestHeaders,
    );
    print(response.body);
    return response.statusCode;
  }
}
