import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/admin_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class AdminController extends GetxController {
  final adminService = AdminService();
  StreamController<List<dynamic>> listMerchant =
      StreamController<List<dynamic>>.broadcast();
  StreamController<List<dynamic>> listTransport =
      StreamController<List<dynamic>>.broadcast();

  getMerchant(status) async {
    var res = await adminService.getMerchantByStatus(status);
    print(res);
    listMerchant.add(res);
  }

  getTransport(status) async {
    var res = await adminService.getTransportByStatus(status);
    listTransport.add(res);
  }

  approveMerchant(idMerchant) async {
    var body = {
      'idMerchant': idMerchant,
    };
    int status = await adminService.approveMerchant(body);
    if (status == 200) {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Cửa hàng sẽ được hiển thị với người dùng!',
        subTitle: 'Các sản phẩm của cửa hàng sẽ được nhìn thấy.',
      );
      getSnackBar.show();
      getMerchant('INACTIVE');
    }
  }

  approveTransport(idTransport) async {
    var body = {
      'idTransport': idTransport,
    };
    int status = await adminService.approveTransport(body);
    if (status == 200) {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Nhà vận chuyển đã được quyền hoạt động!',
        subTitle: 'Người dùng có thể chọn nhà vận chuyển này.',
      );
      getSnackBar.show();
      getTransport('INACTIVE');
    }
  }

  cancelMerchant(idMerchant) async {
    var body = {
      'idMerchant': idMerchant,
    };
    int status = await adminService.cancelMerchant(body);
    if (status == 200) {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã chấm dứt hợp tác với cửa hàng!',
        subTitle: 'Các sản phẩm của cửa hàng sẽ được ẩn đi.',
      );
      getSnackBar.show();
      getMerchant('ACTIVE');
    }
  }

  cancelTransport(idTransport) async {
    var body = {
      'idTransport': idTransport,
    };
    int status = await adminService.cancelTransport(body);
    if (status == 200) {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã chấm dứt hợp tác với nhà vận chuyển!',
        subTitle: 'Các sản phẩm của cửa hàng sẽ được ẩn đi.',
      );
      getSnackBar.show();
      getTransport('ACTIVE');
    }
  }

  rejectMerchant(idMerchant) async {
    var body = {
      'idMerchant': idMerchant,
    };
    int status = await adminService.rejectMerchant(body);
    if (status == 200) {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã xoá lời mời hợp tác từ cửa hàng!',
        subTitle: 'Yêu cầu của cửa hàng sẽ bị xoá.',
      );
      getSnackBar.show();
      getMerchant('INACTIVE');
    }
  }

  rejectTransport(idTransport) async {
    var body = {
      'idTransport': idTransport,
    };
    int status = await adminService.rejectMerchant(body);
    if (status == 200) {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Bạn đã xoá lời mời hợp tác từ nhà vận chuyển!',
        subTitle: 'Yêu cầu của nhà vẫn chuyển sẽ bị xoá.',
      );
      getSnackBar.show();
      getTransport('INACTIVE');
    }
  }

  Stream<dynamic> get getMerchantStream => listMerchant.stream;
  Stream<dynamic> get getTransportStream => listTransport.stream;
}
