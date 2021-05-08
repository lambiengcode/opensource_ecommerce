import 'package:http/http.dart' as http;
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/routes.dart';
import 'package:van_transport/src/common/secret_key.dart';

class TransportService {
  Map<String, String> requestHeaders = {
    'Authorization': 'Bearer ${App.token}',
  };

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
      headers: requestHeaders,
    );
    print(body);
    print(response.body);
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
}
