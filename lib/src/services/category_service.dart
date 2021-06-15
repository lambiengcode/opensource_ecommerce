import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';

class CategoryService {
  Future<List<Map<String, dynamic>>> getCategories() async {
    var response = await http.get(
      baseUrl + ApiGateway.GET_CATEGORIES,
      headers: getHeaders(),
    );
    return convert.jsonDecode(response.body)['data'];
  }

  Future<int> createCategory(body) async {
    var response = await http.post(
      baseUrl + ApiGateway.CREATE_CATEGORY,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> updateCategory(body) async {
    var response = await http.put(
      baseUrl + ApiGateway.UPDATE_CATEGORY,
      body: body,
      headers: getHeaders(),
    );
    return response.statusCode;
  }

  Future<int> deleteCategory(idCategory) async {
    var response = await http.delete(
      baseUrl + ApiGateway.DELETE_CATEGORY + idCategory,
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
