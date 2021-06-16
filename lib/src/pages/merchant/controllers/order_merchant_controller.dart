import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/merchant_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class OrderMerchantController extends GetxController {
  final merchantService = MerchantService();
  StreamController<List<dynamic>> cartController =
      StreamController<List<dynamic>>.broadcast();

  getOrder(status) async {
    var res = await merchantService.getOrderByStatus(status);
    cartController.add(res);
    print(res);
  }

  cancelOrder(idOrder) async {
    var status = await merchantService.cancelOrder(idOrder);
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

  Stream<List<dynamic>> get getCartController => cartController.stream;
}
