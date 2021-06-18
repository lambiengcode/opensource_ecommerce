import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/transport_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class TransportController extends GetxController {
  TransportService transportService = TransportService();
  StreamController<dynamic> transportController =
      StreamController<dynamic>.broadcast();
  StreamController<List<dynamic>> subTransportController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<List<dynamic>> assignStaffController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<dynamic> statisticController =
      StreamController<dynamic>.broadcast();
  Map<String, dynamic> transportInfo;

  getTransport() async {
    var res = await transportService.getTransport();
    transportController.add(res);
    transportInfo = res;
    update();
  }

  getAssignTransport() async {
    var res = await transportService.getAssignStaff();
    assignStaffController.add(res);
  }

  getAllSubTransportByStatus(status) async {
    var res = await transportService.getSubTransportByStatus(status);
    print(res);
    subTransportController.add(res);
  }

  getStatistic(period, type) async {
    var res = await transportService.getStatistic(period, type);
    statisticController.add(res['data']);
  }

  editTransport(
    id,
    name,
    description,
    avatar,
    phone,
    headquarters,
  ) async {
    var body = {
      "name": name,
      "description": description,
      "avatar": avatar,
      "phone": phone,
      "headquarters": headquarters,
    };
    int status = await transportService.updateTransport(body);
    if (status == 200) {
      getTransport();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  registerStaff(email, phone, fullName, password, image) async {
    var body = {
      'email': email,
      'phone': phone,
      'fullName': fullName,
      'password': password,
      'image': image,
    };

    int status = await transportService.registerStaff(body);
    print(status);
    if (status == 200) {
      getAssignTransport();
      Get.back();
    } else {
      Get.back();
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Đăng kí thất bại',
        subTitle: 'Hãy kiểm tra lại thông tin bạn nhập',
      );
      getSnackBar.show();
    }
  }

  updatePriceType(title, price, avalable, type) async {
    var body = {
      'title': title,
      'price': price,
      'available': avalable,
      'type': type,
    };

    var res = await transportService.updatePriceType(body);
    if (res != null) {
      Get.back();
      Get.back();
      Get.toNamed(Routes.DELIVERY + Routes.EDITDELIVERY, arguments: res);
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Cập nhật thất bại!',
        subTitle: 'Hãy kiểm tra lại thông tin.',
      );
      getSnackBar.show();
    }
  }

  createSubTransport(locationCity, lat, lng, locationAddress) async {
    var body = {
      "locationCity": locationCity,
      "locationCoordinateLat": lat,
      "locationCoordinateLng": lng,
      "locationAddress": locationAddress,
    };

    int status = await transportService.createTransportSub(body);
    if (status == 200) {
      Get.back();
      getTransport();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  deleteSubTransport(id) async {
    var body = {
      "idSub": id,
      "status": false,
    };

    int status = await transportService.deleteTransportSub(body);
    if (status == 200) {
      Get.back();
      getTransport();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  assignStaff(idSub, idUser) async {
    var body = {
      "idUser": idUser,
      "idSub": idSub,
    };

    int status = await transportService.assignTransport(body);
    if (status == 200) {
      getAssignTransport();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getTransportStream => transportController.stream;
  Stream<dynamic> get getSubTransportStream => subTransportController.stream;
  Stream<dynamic> get getAssignStaffStream => assignStaffController.stream;
  Stream<dynamic> get getStatisticStream => statisticController.stream;
}
