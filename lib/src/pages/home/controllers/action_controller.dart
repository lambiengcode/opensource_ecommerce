import 'package:get/get.dart';

class ActionController extends GetxController {
  int index = 0;

  void updateType(int input) {
    index = input;
    update();
  }
}
