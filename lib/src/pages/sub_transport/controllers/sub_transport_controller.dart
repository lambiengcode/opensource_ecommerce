import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/transport_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

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

  cancelOrder(idOrder) async {
    var status = await transportService.cancelOrder(idOrder);
    if (status == 200) {
      Get.back();
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã từ chối đơn hàng thành công!',
        subTitle: 'Kiểm tra lại thông tin đơn hàng trong từ chối.',
      );
      getSnackBar.show();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn không thể huỷ đơn hàng!',
        subTitle: 'Quá trình xử lí đơn hàng đang bị lỗi.',
      );
      getSnackBar.show();
    }
  }

  Stream<Map<String, dynamic>> get getSubTransportController =>
      subTransportController.stream;
  Stream<List<dynamic>> get getCartController => cartController.stream;
}
