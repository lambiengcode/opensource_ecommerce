import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DistanceService {
  Future<Map<String, dynamic>> calculateDistance(lat1, lon1, lat2, lon2) async {
    var res = await http.get(
        'https://route.ls.hereapi.com/routing/7.2/calculateroute.json?waypoint0=$lat1,$lon1&waypoint1=$lat2,$lon2&mode=fastest%3Bcar%3Btraffic%3Aenabled&departure=now&apiKey=A0tWGK_QH7VK9JBfNHvnjA3a3yzO1M86BerlPdJy7bU');
    print(convert.jsonDecode(res.body));
    return convert.jsonDecode(res.body);
  }
}
