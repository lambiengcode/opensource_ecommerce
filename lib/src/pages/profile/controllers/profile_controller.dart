import 'dart:async';

import 'package:get/get.dart';
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

  Stream<dynamic> get getProfileController => profileController.stream;
}
