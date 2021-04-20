import 'package:get/get.dart';

class SettingsController extends GetxController {
  bool notification = true;

  void updateNotification() {
    notification = !notification;
    update();
  }
}
