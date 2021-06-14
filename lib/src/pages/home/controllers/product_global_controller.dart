import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:van_transport/src/services/merchant_service.dart';

class ProductGlobalController extends GetxController {
  final productService = MerchantService();
  String merchantName = '';
  int page = 1;

  List<dynamic> listProduct1 = [];
  List<dynamic> listProduct2 = [];
  List<dynamic> listProduct3 = [];
  List<dynamic> listProduct4 = [];

  getProduct() async {
    var res = await productService.getProduct(page.toString());
    res
        .where((e) {
          return !e.toString().contains('http');
        })
        .toList()
        .forEach(res.remove);
    res.shuffle();
    listProduct1.addAll(res);
    res.shuffle();
    listProduct2.addAll(res.reversed);
    res.shuffle();
    listProduct3.addAll(res);
    res.shuffle();
    if (page > 0 && page < 3) {
      listProduct4.addAll(res);
    }
    if (res.length > 0) {
      page++;
    }
    update();
  }

  getMerchantById(idMerchant) async {
    var res = await productService.getMerchantById(idMerchant);
    if (idMerchant != null) {
      merchantName = res['name'];
      update();
    }
  }
}
