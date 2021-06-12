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
    assignStaffController.add(res);
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

  updatePriceType(title, price, avalable, type) async {
    var body = {
      'title': title,
      'price': price,
      'avalable': avalable,
      'type': type,
    };

    print(body);

    var res = await transportService.updatePriceType(body);
    if (res != null) {
      transportController.add(res);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  createSubTransport(locationCity, lat, lng, locationCountry, locationWard,
      locationAddress) async {
    var body = {
      "locationCity": locationCity,
      "locationCoordinateLat": lat,
      "locationCoordinateLng": lng,
      "locationCounty": locationCountry,
      "locationWard": locationWard,
      "locationAddress": locationAddress,
    };

    int status = await transportService.createTransportSub(body);
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

  deleteSubTransport(id) async {
    var body = {
      "idSub": id,
      "status": false,
    };

    int status = await transportService.deleteTransportSub(body);
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
