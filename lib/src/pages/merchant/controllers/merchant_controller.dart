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
  StreamController<List<dynamic>> productController =
      StreamController<List<dynamic>>.broadcast();

  getMerchant() async {
    var res = await merchantService.getMerchant();
    merchantController.add(res);
  }

  getGroupProduct(idMerchant) async {
    var res = await merchantService.getGroupProduct(idMerchant);
    groupProductController.add(res);
  }

  getProductByGroup(idGroup) async {
    var res = await merchantService.getProductByGroup(idGroup);
    print(res);
    productController.add(res);
  }

  createGroupProduct(name, description, idMerchant) async {
    var body = {
      'name': name,
      'description': description,
      'FK_merchant': idMerchant,
    };
    int status = await merchantService.createGroupProduct(body);
    if (status == 200) {
      getGroupProduct(idMerchant);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure!',
        subTitle: 'Group product name exists',
      );
      getSnackBar.show();
    }
  }

  createProduct(
    name,
    description,
    price,
    total,
    image,
    idMerchant,
    idGroup,
  ) async {
    var body = {
      'name': name,
      'description': description,
      'price': price.toString().replaceAll(',', ''),
      'total': total,
      'image': image,
      'FK_merchant': idMerchant,
      'FK_groupProduct': idGroup,
    };
    int status = await merchantService.createProduct(body);
    if (status == 200) {
      getProductByGroup(idGroup);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure!',
        subTitle: 'Check again product infomations.',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getMerchantStream => merchantController.stream;
  Stream<List<dynamic>> get getGroupProductStream =>
      groupProductController.stream;
  Stream<List<dynamic>> get getProductStream => productController.stream;
}
