import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/user_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class CartClientController extends GetxController {
  final userService = UserService();
  StreamController<List<dynamic>> listCartController =
      StreamController<List<dynamic>>.broadcast();
  String weight;
  int typeProduct = 0;

  List<String> valueSendServer = [
    'Standard',
    'Frozen',
    'Jewelry',
  ];

  getListCart() async {
    var res = await userService.getCartClient();
    print(res);
    listCartController.add(res);
  }

  addProductToCart(name, List<String> images) async {
    var body = {
      "name": "Quat Sanko",
      "weight": weight,
      "type": valueSendServer[typeProduct].toString(),
      "image": images.join(' '),
    };

    int status = await userService.addProductToCartClient(body);
    if (status == 200) {
      getListCart();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Add failure!',
        subTitle: 'Check again product infomations.',
      );
      getSnackBar.show();
    }
  }

  setWeight(weight) {
    this.weight = weight;
    update();
  }

  setTypeProduct(index) {
    this.typeProduct = index;
    update();
    Get.back();
  }

  Stream<List<dynamic>> get getListCartController => listCartController.stream;
}
