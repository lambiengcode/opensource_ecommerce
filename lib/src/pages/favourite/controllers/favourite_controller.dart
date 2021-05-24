import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/user_service.dart';

class FavouriteController extends GetxController {
  final UserService userService = UserService();
  StreamController<List<Map<String, dynamic>>> favouritesController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  getFavourites() async {
    var res = await userService.getFavorites();
    favouritesController.add(res);
  }

  favourite(idProduct) async {
    var body = {
      'id': idProduct,
    };
    var status = await userService.favorite(body);
    if (status == 200) {
      getFavourites();
    }
  }

  Stream<List<Map<String, dynamic>>> get getFavouritesStream =>
      favouritesController.stream;
}
