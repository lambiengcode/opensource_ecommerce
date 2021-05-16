import 'dart:async';

import 'package:get/get.dart';
import 'package:van_transport/src/services/merchant.dart';

class MerchantController extends GetxController {
  MerchantService merchantService = MerchantService();
  StreamController<dynamic> merchantController =
      StreamController<dynamic>.broadcast();

  getMerchant() async {
    var res = await merchantService.getMerchant();
    merchantController.add(res);
  }

  Stream<dynamic> get getMerchantStream => merchantController.stream;
}
