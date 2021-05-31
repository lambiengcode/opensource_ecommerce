import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/coupon_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class CategoryController extends GetxController {
  final couponService = CouponService();
  StreamController<List<Map<String, dynamic>>> couponController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  getCoupon() async {
    var res = await couponService.getCoupons();
    couponController.add(res);
  }

  createCoupon(name) async {
    var body = {
      'name': name,
    };
    var status = await couponService.createCoupon(body);
    if (status == 200) {
      getCoupon();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  updateCoupon(idCategory, name) async {
    var body = {
      'id': idCategory,
      'name': name,
    };
    var status = await couponService.updateCoupon(body);
    if (status == 200) {
      getCoupon();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  deleteCoupon(idCoupon) async {
    var status = await couponService.deleteCoupon(idCoupon);
    if (status == 200) {
      getCoupon();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete failure',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  Stream<List<Map<String, dynamic>>> get getCouponStream =>
      couponController.stream;
}
