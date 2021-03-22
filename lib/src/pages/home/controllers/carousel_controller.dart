import 'package:get/get.dart';

class CarouselBannerController extends GetxController {
  int index = 0;

  CarouselBannerController({this.index});

  void updateIndex(int input) {
    index = input;
    update();
  }
}
