import 'dart:async';
import 'package:get/get.dart';
import 'package:van_transport/src/services/category_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class CategoryController extends GetxController {
  final categoryService = CategoryService();
  StreamController<List<Map<String, dynamic>>> categoryController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  getCategory() async {
    var res = await categoryService.getCategories();
    categoryController.add(res);
  }

  createCategory(name) async {
    var body = {
      'name': name,
    };
    var status = await categoryService.createCategory(body);
    if (status == 200) {
      getCategory();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Create failure',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  updateCategory(idCategory, name) async {
    var body = {
      'id': idCategory,
      'name': name,
    };
    var status = await categoryService.updateCategory(body);
    if (status == 200) {
      getCategory();
      Get.back();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Update failure',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  deleteCategory(idCategory) async {
    var status = await categoryService.deleteCategory(idCategory);
    if (status == 200) {
      getCategory();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Delete failure',
        subTitle: 'Check again your information.',
      );
      getSnackBar.show();
    }
  }

  Stream<List<Map<String, dynamic>>> get getCategoryStream =>
      categoryController.stream;
}
