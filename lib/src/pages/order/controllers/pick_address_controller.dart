import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/distance_service.dart';
import 'package:van_transport/src/services/user_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class PickAddressController extends GetxController {
  StreamController<dynamic> listTransport =
      StreamController<dynamic>.broadcast();
  final DistanceService distanceService = DistanceService();
  final userService = UserService();
  String placeTo, placeFrom;
  LatLng locationTo, locationFrom;
  String distance;
  String idAddress;
  var senderInfo, recipientInfo, transportInfo;

  initData() {
    placeTo = '';
    placeFrom = '';
    update();
  }

  pickAddress(PickResult input) {
    locationTo = LatLng(
      input.geometry.location.lat,
      input.geometry.location.lng,
    );
    placeTo = input.formattedAddress;
    update();
  }

  pickFromAddress(lat, lng, fullAddress, idAddress) {
    locationFrom = LatLng(
      lat,
      lng,
    );
    placeFrom = fullAddress;
    this.idAddress = idAddress;
    update();
  }

  calDistance() async {
    var res = await distanceService.calculateDistance(
      locationFrom.latitude,
      locationFrom.longitude,
      locationTo.latitude,
      locationTo.longitude,
    );
    distance = res['rows'][0]['elements'][0]['distance']['text'];
    update();
  }

  getListTransport(idMerchant) async {
    var res = await userService.getTransportDelivery(idAddress, idMerchant);
    listTransport.add(res);
  }

  pickDelivery(sender, recipient, transportInfo) {
    this.transportInfo = transportInfo;
    senderInfo = sender;
    recipientInfo = recipient;
    update();
  }

  paymentCartMerchant() async {
    var body = {
      "title": "Đơn hàng Van Transport",
      "description": "Đơn hàng mới",
      "recipientAddress": recipientInfo['fullAddress'],
      "recipientLat": recipientInfo['coordinates']['lat'],
      "recipientLng": recipientInfo['coordinates']['lng'],
      "recipientPhone": recipientInfo['phoneNumber'],
      "senderName": senderInfo['name'],
      "senderPhone": senderInfo['address']['phoneNumber'],
      "senderAddress": senderInfo['address']['fullAddress'],
      "senderLat": senderInfo['address']['coordinates']['lat'],
      "senderLng": senderInfo['address']['coordinates']['lng'],
      "FK_Transport": transportInfo['FK_Transport']['_id'],
      "FK_SubTransport": transportInfo['start']['_id'],
      "FK_SubTransportAwait": transportInfo['end']['_id'],
      "distance": transportInfo['distance'],
      "prices": transportInfo['price'],
      "weight": "0",
      "estimatedDate": "1622221281950",
    };

    int status = await userService.paymentCartMerchant(body);
    if (status == 200) {
      transportInfo = null;
      senderInfo = null;
      recipientInfo = null;
      idAddress = null;
      Get.offAndToNamed(Routes.ROOT);
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Mua hàng thành công!',
        subTitle: 'Kiểm tra lại đơn hàng nhé.',
      );
      getSnackBar.show();
    } else {
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Payment failure!',
        subTitle: 'Check again your infomation',
      );
      getSnackBar.show();
    }
  }

  Stream<dynamic> get getListTransportController => listTransport.stream;
}
