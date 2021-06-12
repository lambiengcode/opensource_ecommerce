import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/user_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class CartMerchantController extends GetxController {
  final userService = UserService();
  StreamController<List<dynamic>> cartController =
      StreamController<List<dynamic>>.broadcast();

  getCartMerchant() async {
    var res = await userService.getCartMerchant();
    cartController.add(res);
  }

  addToCart(idProduct, quantity) async {
    var body = {
      'idProduct': idProduct,
      'quantity': quantity,
    };

    int status = await userService.addProductToCartMerchant(body);
    if (status == 200) {
      getCartMerchant();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Add failure!',
        subTitle: 'Check again product infomations.',
      );
      getSnackBar.show();
    }
  }

  Stream<List<dynamic>> get getCartController => cartController.stream;
}
