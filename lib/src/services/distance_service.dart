import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DistanceService {
  Future<Map<String, dynamic>> calculateDistance(lat1, lon1, lat2, lon2) async {
    var res = await http.get(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$lat1,$lon1&destinations=$lat2,$lon2&key=AIzaSyAURwoHCVzWdOHBMpP9vDsxgvZVB7-spLI&mode=driving');

    return convert.jsonDecode(res.body);
  }
}
