import 'dart:async';

import 'package:get/get.dart';
import 'package:van_transport/src/services/merchant.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class MerchantController extends GetxController {
  MerchantService merchantService = MerchantService();
  StreamController<dynamic> merchantController =
      StreamController<dynamic>.broadcast();
  StreamController<List<dynamic>> groupProductController =
      StreamController<List<dynamic>>.broadcast();

  getMerchant() async {
    var res = await merchantService.getMerchant();
    merchantController.add(res);
  }

  getGroupProduct(idMerchant) async {
    var res = await merchantService.getGroupProduct(idMerchant);
    groupProductController.add(res);
  }

  createGroupProduct(name, idMerchant) async {
    var body = {
      'name': name,
      'FK_merchant': idMerchant,
    };
    int status = await merchantService.createGroupProduct(body);
    if (status == 200) {
      getGroupProduct(idMerchant);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure',
        subTitle: 'Group product name exists',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getMerchantStream => merchantController.stream;
  Stream<List<dynamic>> get getGroupProductStream =>
      groupProductController.stream;
}
