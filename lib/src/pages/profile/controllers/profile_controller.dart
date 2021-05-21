import 'dart:async';

import 'package:get/get.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/user.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class ProfileController extends GetxController {
  UserService userService = UserService();
  StreamController<dynamic> profileController =
      StreamController<dynamic>.broadcast();

  getProfile() async {
    var mProfile = await userService.getProfile();
    profileController.add(mProfile);
  }

  updateProfile(fullName, phone, image) async {
    var body = {
      'fullName': fullName,
      'image': image,
      'phone': phone,
    };
    int res = await userService.updateProfile(body);
    if (res == 200) {
      getProfile();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update profile failure!',
        subTitle: 'Check again your infomation',
      );
      getSnackBar.show();
    }
  }

  buyPoint(point, method) async {
    var body = {
      'point': point.toString().replaceAll(',', '').replaceAll(' points', ''),
      'typePayment': method,
    };
    String url = await userService.buyPoint(body);
    if (url != null) {
      Get.toNamed(Routes.PAYMENTWEBVIEW, arguments: url);
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Buy point failure!',
        subTitle: 'Check again your infomation',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getProfileController => profileController.stream;
}
