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
    listCartController.add(res);
  }

  deleteCartClient(idProduct) async {
    var body = {
      "idProduct": idProduct,
    };
    var status = await userService.deleteItemCartClient(body);
    if (status == 200) {
      getListCart();
    }
  }

  addProductToCart(name, List<String> images) async {
    var body = {
      "name": name,
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

  updateProductToCart(id, name, List<String> images) async {
    var body = {
      "idProduct": id,
      "name": name,
      "weight": weight,
      "type": valueSendServer[typeProduct].toString(),
      "image": images.join(' '),
    };

    int status = await userService.updateProductToCartClient(body);
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

  setTypeProductByString(type) {
    int index = valueSendServer.indexOf(type);
    this.typeProduct = index;
    update();
  }

  Stream<List<dynamic>> get getListCartController => listCartController.stream;
}
