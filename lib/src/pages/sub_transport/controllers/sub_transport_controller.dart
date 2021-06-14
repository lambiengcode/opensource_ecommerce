import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/transport_service.dart';

class SubTransportController extends GetxController {
  final transportService = TransportService();
  String idSubTransport = '';
  StreamController<Map<String, dynamic>> subTransportController =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<List<dynamic>> cartController =
      StreamController<List<dynamic>>.broadcast();

  getInfo() async {
    var res = await transportService.getSubTransport();
    subTransportController.add(res);
    print(res);
    idSubTransport = res['_id'];
    update();
  }

  getOrder(status) async {
    var res = await transportService.getOrderByStatus(status, idSubTransport);
    cartController.add(res);
    print(res);
  }

  cancelOrder(idOrder) async {}

  acceptReceiveOrder(idOrder) async {}

  Stream<Map<String, dynamic>> get getSubTransportController =>
      subTransportController.stream;
  Stream<List<dynamic>> get getCartController => cartController.stream;
}
