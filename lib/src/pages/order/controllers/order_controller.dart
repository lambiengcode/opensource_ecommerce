import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/user_service.dart';

class OrderController extends GetxController {
  final userService = UserService();
  StreamController<List<dynamic>> cartController =
      StreamController<List<dynamic>>.broadcast();

  getOrder(status) async {
    var res = await userService.getOrderByStatus(status);
    cartController.add(res);
    print(res);
  }

  cancelOrder(idOrder) async {}

  acceptReceiveOrder(idOrder) async {}

  Stream<List<dynamic>> get getCartController => cartController.stream;
}
