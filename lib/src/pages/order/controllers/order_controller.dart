import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/user_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class OrderController extends GetxController {
  final userService = UserService();
  StreamController<List<dynamic>> cartController =
      StreamController<List<dynamic>>.broadcast();

  getOrder(status) async {
    var res = await userService.getOrderByStatus(status);
    cartController.add(res);
  }

  cancelOrder(idOrder) async {
    int status = await userService.cancelOrder(idOrder);
    if (status == 200) {
      Get.back();
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã huỷ đơn hàng thành công!',
        subTitle: 'Bạn đã được hoàn tiền 95% giá trị đơn hàng.',
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

  acceptReceiveOrder(idOrder) async {
    int status = await userService.receiveOrder(idOrder);
    if (status == 200) {
      Get.back();
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã nhận hàng thành công!',
        subTitle: 'Hãy xem lịch sử đơn hàng trong lịch sử.',
      );
      getSnackBar.show();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn không thể nhận hàng!',
        subTitle: 'Quá trình xử lí đơn hàng đang bị lỗi.',
      );
      getSnackBar.show();
    }
  }

  Stream<List<dynamic>> get getCartController => cartController.stream;
}
