import 'dart:async';

import 'package:get/get.dart';
import 'package:van_transport/src/services/merchant_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class MerchantController extends GetxController {
  MerchantService merchantService = MerchantService();
  StreamController<dynamic> merchantController =
      StreamController<dynamic>.broadcast();
  StreamController<List<dynamic>> groupProductController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<List<dynamic>> productController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<dynamic> statisticController =
      StreamController<dynamic>.broadcast();

  List<dynamic> products1 = [];
  List<dynamic> products2 = [];
  List<dynamic> products3 = [];
  List<dynamic> products4 = [];

  getMerchant() async {
    var res = await merchantService.getMerchant();
    merchantController.add(res);
  }

  getGroupProduct(idMerchant) async {
    var res = await merchantService.getGroupProduct(idMerchant);
    groupProductController.add(res);
  }

  getStatistic(period, type) async {
    var res = await merchantService.getStatistic(period, type);
    statisticController.add(res['data']);
  }

  getProductByGroup(idGroup, page) async {
    if (page == 1) {
      products1.clear();
      products2.clear();
      products3.clear();
      products4.clear();
    }
    var res = await merchantService.getProductByGroup(idGroup, page);
    print(res);
    if (res.length > 0) {
      products1.addAll(res);
      res.shuffle();
      products2.addAll(res);
      res.shuffle();
      products3.addAll(res);
      res.shuffle();
      products4.addAll(res);
      productController.add(products1);
      update();
    }
  }

  getProductByMerchant(idGroup, page) async {
    var res = await merchantService.getProductByMerchant(idGroup, page);
    if (page == 1) {
      products1.clear();
      products2.clear();
      products3.clear();
      products4.clear();
    }
    if (res.length > 0) {
      products1.addAll(res);
      res.shuffle();
      products2.addAll(res);
      res.shuffle();
      products3.addAll(res);
      res.shuffle();
      products4.addAll(res);
      update();
    }
  }

  createMerchant(
    name,
    description,
    image,
    address,
    phone,
    lat,
    lng,
  ) async {
    var body = {
      "name": name,
      "description": description,
      "image": image,
      "phone": phone,
      "fullAddress": address,
      "lat": lat,
      "lng": lng,
    };
    int status = await merchantService.createMerchant(body);
    if (status == 200) {
      getMerchant();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create merchant successfully',
        subTitle: 'Please wait for admin check your request.',
      );
      getSnackBar.show();
    }
  }

  editMerchant(
    id,
    name,
    description,
    image,
    address,
    phone,
    lat,
    lng,
  ) async {
    var body = {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "phone": phone,
      "fullAddress": address,
      "lat": lat,
      "lng": lng,
    };
    int status = await merchantService.updateMerchant(body);
    if (status == 200) {
      getMerchant();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
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
      getProductByGroup(idGroup, 1);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure!',
        subTitle: 'Check again product infomations.',
      );
      getSnackBar.show();
    }
  }

  updateProduct(
    idProduct,
    name,
    description,
    price,
    total,
    image,
    idMerchant,
    idGroup,
  ) async {
    var body = {
      'idProduct': idProduct,
      'name': name,
      'description': description,
      'price': price.toString().replaceAll(',', ''),
      'total': total,
      'image': image,
      'FK_merchant': idMerchant,
      'FK_groupProduct': idGroup,
    };
    int status = await merchantService.updateProduct(body);
    if (status == 200) {
      getProductByGroup(idGroup, 1);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure!',
        subTitle: 'Check again product infomations.',
      );
      getSnackBar.show();
    }
  }

  updateGroupProduct(
    idMerchant,
    idGroup,
    name,
    description,
  ) async {
    var body = {
      '_id': idGroup,
      'name': name,
      'description': description,
    };
    int status = await merchantService.updateGroupProduct(body);
    if (status == 200) {
      getGroupProduct(idMerchant);
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure!',
        subTitle: 'Check again group product infomations.',
      );
      getSnackBar.show();
    }
  }

  deleteProduct(idProduct, idGroup) async {
    int status = await merchantService.deleteProduct(idProduct);
    if (status == 200) {
      getProductByGroup(idGroup, 1);
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete product success!',
        subTitle: 'Your list product already update.',
      );
      getSnackBar.show();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete product failure!',
        subTitle: 'Check again product infomations.',
      );
      getSnackBar.show();
    }
  }

  deleteGroupProduct(idGroup, idMerchant) async {
    int status = await merchantService.deleteGroupProduct(idGroup);
    if (status == 200) {
      getProductByGroup(idGroup, 1);
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete group product success!',
        subTitle: 'Your group product already update.',
      );
      getSnackBar.show();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete group product failure!',
        subTitle: 'Check again group product infomations.',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getMerchantStream => merchantController.stream;
  Stream<List<dynamic>> get getGroupProductStream =>
      groupProductController.stream;
  Stream<List<dynamic>> get getProductStream => productController.stream;
  Stream<dynamic> get getStatisticStream => statisticController.stream;
}
