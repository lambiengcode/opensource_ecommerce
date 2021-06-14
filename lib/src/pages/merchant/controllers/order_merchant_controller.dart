import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/merchant_service.dart';

class OrderMerchantController extends GetxController {
  final merchantService = MerchantService();
  StreamController<List<dynamic>> cartController =
      StreamController<List<dynamic>>.broadcast();

  getOrder(status) async {
    var res = await merchantService.getOrderByStatus(status);
    cartController.add(res);
    print(res);
  }

  cancelOrder(idOrder) async {}

  acceptReceiveOrder(idOrder) async {}

  Stream<List<dynamic>> get getCartController => cartController.stream;
}
