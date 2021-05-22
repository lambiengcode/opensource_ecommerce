import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/user_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class ProfileController extends GetxController {
  UserService userService = UserService();
  StreamController<dynamic> profileController =
      StreamController<dynamic>.broadcast();
  bool loading = false;

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
    loading = true;
    update();
    var body = {
      'point': point.toString().replaceAll(',', '').replaceAll(' points', ''),
      'typePayment': method,
    };
    String url = await userService.buyPoint(body);
    loading = false;
    update();
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

  addAddress(PickResult pickResult, phone) async {
    var body = {
      'fullAddress': pickResult.formattedAddress.toString(),
      'lat': pickResult.geometry.location.lat.toString(),
      'lng': pickResult.geometry.location.lng.toString(),
      'phone': phone,
    };
    int status = await userService.addAddress(body);
    if (status == 200) {
      getProfile();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Add address failure!',
        subTitle: 'Check again your address infomation',
      );
      getSnackBar.show();
    }
  }

  updateAddress(id, lat, lng, fullAddress, phone) async {
    var body = {
      'id': id,
      'fullAddress': fullAddress,
      'lat': lat,
      'lng': lng,
      'phone': phone,
    };
    int status = await userService.updateAddress(body);
    if (status == 200) {
      getProfile();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update address failure!',
        subTitle: 'Check again your address infomation',
      );
      getSnackBar.show();
    }
  }

  deleteAddress(id) async {
    int status = await userService.deleteAddress(id);
    if (status == 200) {
      getProfile();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete address failure!',
        subTitle: 'Check again your address infomation',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getProfileController => profileController.stream;
}
