import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressController extends GetxController {
  String placeTo, placeFrom;
  LatLng locationTo, locationFrom;

  initData() {
    placeTo = '';
    placeFrom = '';
    update();
  }

  pickAddress(input) {
    locationTo = input;
    update();
  }
}
