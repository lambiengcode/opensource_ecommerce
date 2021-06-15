import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/user_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class FavouriteController extends GetxController {
  final UserService userService = UserService();
  StreamController<List<dynamic>> favouritesController =
      StreamController<List<dynamic>>.broadcast();
  bool isFavourite = false;
  List<dynamic> favourites = [];

  getFavourites() async {
    var res = await userService.getFavorites();
    favouritesController.add(res);
    favourites.addAll(res);
    update();
  }

  favourite(idProduct) async {
    checkIsFavourite(idProduct);
    var body = {
      'id': idProduct,
    };
    var status = await userService.favorite(body);
    if (status == 200) {
      getFavourites();
      if (!isFavourite) {
        GetSnackBar getSnackBar = GetSnackBar(
            title: 'Bạn đã yêu thích sản phẩm!',
            subTitle: 'Đã lưu vào danh sách yêu thích.');
        getSnackBar.show();
      }
      isFavourite = !isFavourite;
      update();
    }
  }

  checkIsFavourite(idProduct) async {
    int index =
        favourites.indexWhere((element) => element['FK_product'] == idProduct);
    isFavourite = index != -1;
    update();
  }

  Stream<dynamic> get getFavouritesStream => favouritesController.stream;
}
