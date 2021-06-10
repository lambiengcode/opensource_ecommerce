import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/transport_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class TransportController extends GetxController {
  TransportService transportService = TransportService();
  StreamController<dynamic> transportController =
      StreamController<dynamic>.broadcast();
  StreamController<List<dynamic>> assignStaffController =
      StreamController<List<dynamic>>.broadcast();

  getTransport() async {
    var res = await transportService.getTransport();
    transportController.add(res);
  }

  getAssignTransport() async {
    var res = await transportService.getAssignStaff();
    print(res);
    assignStaffController.add(res);
  }

  editTransport(
    id,
    name,
    description,
    avatar,
    imageVerify,
    phone,
    headquarters,
  ) async {
    var body = {
      "id": id,
      "name": name,
      "description": description,
      "avatar": avatar,
      "imageVerify": imageVerify,
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
    if (status == 200) {
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  updatePriceType(price, avalable, type) async {
    var body = {
      'price': price,
      'avalable': avalable,
      'type': type,
    };

    int status = await transportService.updatePriceType(body);
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

  Stream<dynamic> get getTransportStream => transportController.stream;
  Stream<dynamic> get getAssignStaffStream => assignStaffController.stream;
}
