import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'dart:math';

class AddressPage extends StatefulWidget {
  const AddressPage({Key key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // var controller = Get.put(ProfileController());
  final kInitialPosition = LatLng(-33.8567844, 151.213108);
  PickResult selectedPlace;
  LocationData currentLocation;
  Future<dynamic> _myLocation;
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  List<dynamic> data = [
    {"lat": 44.968046, "lng": -94.420307},
    {"lat": 44.33328, "lng": -89.132008},
    {"lat": 33.755787, "lng": -116.359998},
    {"lat": 33.844843, "lng": -116.54911},
    {"lat": 44.92057, "lng": -93.44786},
    {"lat": 44.240309, "lng": -91.493619},
    {"lat": 44.968041, "lng": -94.419696},
    {"lat": 44.333304, "lng": -89.132027},
    {"lat": 33.755783, "lng": -116.360066},
    {"lat": 33.844847, "lng": -116.549069},
  ];

  getUserLocation() async {
    //call this async method from whereever you need

    LocationData myLocation;
    String error;
    Location location = new Location();

    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String result = '${first.addressLine}';
    print(
        ' ${first.locality},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return result;
  }

  void chooseLocation(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlacePicker(
            apiKey: apiMap,
            initialPosition: kInitialPosition,
            useCurrentLocation: true,
            selectInitialPosition: true,
            onGeocodingSearchFailed: (error) => print(error),
            usePlaceDetailSearch: true,
            forceSearchOnZoomChanged: true,
            automaticallyImplyAppBarLeading: false,
            usePinPointingSearch: true,
            autocompleteLanguage:
                Get.locale == Locale('vi', 'VN') ? 'vi' : 'en',
            region: Get.locale == Locale('vi', 'VN') ? 'vn' : 'us',
            selectedPlaceWidgetBuilder:
                (_, selectedP, state, isSearchBarFocused) {
              print("state: $state, isSearchBarFocused: $isSearchBarFocused");
              return isSearchBarFocused
                  ? Container()
                  : FloatingCard(
                      bottomPosition:
                          0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                      leftPosition: 0.0,
                      rightPosition: 0.0,
                      width: 600.0,
                      height: 125.0,
                      borderRadius: BorderRadius.circular(12.0),
                      child: state == SearchingState.Searching
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  colorTitle,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text(
                                    selectedP.formattedAddress,
                                    style: TextStyle(
                                        color: colorTitle,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 18.0,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 600.0,
                                    child: RaisedButton(
                                      color: colorTitle,
                                      child: Text(
                                        'pick'.trArgs(),
                                        style: TextStyle(
                                          color: colorPrimaryTextOpacity,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectedPlace = selectedP;
                                        });
                                        Get.back();
                                        print(selectedPlace
                                            .geometry.location.lat);
                                        print(selectedPlace
                                            .geometry.location.lng);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    );
            },
            pinBuilder: (context, state) {
              if (state == PinState.Idle) {
                return CircleAvatar(
                  radius: 12.0,
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/60530946?v=4',
                  ),
                );
              } else {
                return CircleAvatar(
                  radius: 12.0,
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/60530946?v=4',
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _myLocation = getUserLocation();
    //controller.streamProfile();
    double totalDistance = 0;
    for (var i = 0; i < data.length; i++) {
      totalDistance = calculateDistance(
        data[i]["lat"],
        data[i]["lng"],
        kInitialPosition.latitude,
        kInitialPosition.longitude,
      );
      print(totalDistance);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        backgroundColor: mC,
        brightness: Brightness.light,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            size: _size.width / 16.0,
            color: Colors.grey.shade800,
          ),
        ),
        title: Text(
          'deliveryAddress'.trArgs(),
          style: TextStyle(
            fontSize: _size.width / 21.5,
            color: colorTitle,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mC,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(
                horizontal: _size.width * .35,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: mCD,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            _buildCurrentLocation(
              context,
              'currentLocation'.trArgs(),
              selectedPlace == null ? "" : selectedPlace.formattedAddress,
              Feather.target,
            ),
            SizedBox(height: 12.0),
            // StreamBuilder(
            //   stream: controller.profileController.stream,
            //   builder: (context, AsyncSnapshot snapshot) {
            //     if (!snapshot.hasData) {
            //       return Container();
            //     }
            //     var mProfile = convert.jsonDecode(snapshot.data)['data'];

            //     return _buildActionLine(
            //       context,
            //       'homeadd'.trArgs(),
            //       mProfile['address'] == '' || mProfile['address'] == null
            //           ? 'Chọn địa chỉ'
            //           : mProfile['address'].toString().length < 10
            //               ? mProfile['address']
            //               : mProfile['address'].toString().substring(0, 10) +
            //                   '...',
            //       Feather.home,
            //       mProfile['address'],
            //     );
            //   },
            // ),
            _buildActionLine(
              context,
              'homeAddress'.trArgs(),
              'Pick Home Address',
              Feather.home,
              '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionLine(context, title, value, icon, fullValue) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Get.toNamed('/homeAddress', arguments: fullValue),
      child: Container(
        padding: EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 20.0),
        decoration: BoxDecoration(
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(10, 10),
              blurRadius: 10,
            ),
            BoxShadow(
              color: mCL,
              offset: Offset(-10, -10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: _size.width / 18.0,
                  color: colorTitle,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: _size.width / 26.8,
                      color: colorTitle,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: _size.width / 27.5,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade700,
                  size: _size.width / 24.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocation(context, title, value, icon) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => chooseLocation(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(10, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: _size.width / 18.0,
              color: colorTitle,
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  value != ''
                      ? Text(
                          value,
                          style: TextStyle(
                            fontSize: _size.width / 26.8,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : FutureBuilder(
                          future: _myLocation,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Text(
                                  'Thành Phố Hồ Chí Minh, Việt Nam',
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: _size.width / 26.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return Text(
                                    'Thành Phố Hồ Chí Minh, Việt Nam',
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }

                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: _size.width / 26.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                            }
                          },
                        ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: _size.width / 26.0,
                      color: colorTitle,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
