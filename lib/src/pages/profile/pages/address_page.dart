import 'package:van_transport/src/common/constant_code.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:van_transport/src/pages/order/controllers/pick_address_controller.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';
import 'package:van_transport/src/pages/profile/widgets/bottom_settings_address.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/distance_service.dart';

class AddressPage extends StatefulWidget {
  final String mode;
  final bool isFrom;
  AddressPage({this.mode, this.isFrom = false});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final pickAddressController = Get.put(PickAddressController());
  final profileController = Get.put(ProfileController());
  final distance = DistanceService();
  PickResult selectedPlace;
  LocationData currentLocation;
  Future<dynamic> _myLocation;
  List<String> values = ['Delete Address'];

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

  void showAddressBottomSheet(id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSettingsAddress(values: values, idAddress: id);
      },
    );
  }

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
    return result;
  }

  void chooseLocation(context) {
    try {
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
                        bottomPosition: 0.0,
                        leftPosition: 0.0,
                        rightPosition: 0.0,
                        width: 600.0,
                        height: 125.0,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
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
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
    _myLocation = getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      floatingActionButton: Container(
        height: width / 6.25,
        width: width / 6.25,
        child: FloatingActionButton(
          backgroundColor: colorTitle,
          child: Icon(
            Feather.plus,
            color: colorPrimaryTextOpacity,
            size: width / 16.0,
          ),
          onPressed: () => Get.toNamed(Routes.CREATEADDRESS),
        ),
      ),
      body: Container(
        color: mC,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0),
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
            _buildCurrentLocation(
              context,
              'currentLocation'.trArgs(),
              selectedPlace == null ? "" : selectedPlace.formattedAddress,
              Feather.target,
            ),
            SizedBox(height: 4.0),
            Expanded(
              child: StreamBuilder(
                stream: profileController.profileController.stream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  var mProfile = snapshot.data['address'];

                  return ListView.builder(
                    itemCount: mProfile.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          if (widget.mode != PICK_ON) {
                            showAddressBottomSheet(mProfile[index]['id']);
                          }
                        },
                        onTap: () {
                          if (widget.mode == PICK_ON) {
                            if (widget.isFrom && widget.isFrom != null) {
                              pickAddressController.pickFromAddress(
                                double.parse(
                                  mProfile[index]['coordinates']['lat'],
                                ),
                                double.parse(
                                  mProfile[index]['coordinates']['lng'],
                                ),
                                mProfile[index]['fullAddress'],
                                mProfile[index]['id'],
                              );
                            } else {
                              pickAddressController.pickAddress(
                                double.parse(
                                  mProfile[index]['coordinates']['lat'],
                                ),
                                double.parse(
                                  mProfile[index]['coordinates']['lng'],
                                ),
                                mProfile[index]['fullAddress'],
                                mProfile[index]['id'],
                                mProfile[index]['phoneNumber'],
                              );
                            }
                            Get.back();
                          } else {
                            Get.toNamed(
                              Routes.EDITADDRESS,
                              arguments: mProfile[index],
                            );
                          }
                        },
                        child: _buildLocation(
                          context,
                          'address'.trArgs() + ' ${index + 1}',
                          mProfile[index]['fullAddress'],
                          Feather.map_pin,
                          mProfile[index]['phoneNumber'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocation(context, title, value, icon) {
    return FutureBuilder(
      future: _myLocation,
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildLocation(
                context, title, 'Thành Phố Hồ Chí Minh, Việt Nam', icon, '');
          default:
            if (snapshot.hasError) {
              return _buildLocation(
                  context, title, 'Thành Phố Hồ Chí Minh, Việt Nam', icon, '');
            }

            return GestureDetector(
              onTap: () {},
              child: _buildLocation(
                  context, title, snapshot.data, icon, '09889917877'),
            );
        }
      },
    );
  }

  Widget _buildLocation(context, title, value, icon, phone) {
    final _size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
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
          title != 'currentLocation'.trArgs()
              ? BoxShadow(
                  color: mCL,
                  offset: Offset(-5, -5),
                  blurRadius: 4,
                )
              : BoxShadow(
                  color: mCL,
                  offset: Offset(-0, -0),
                  blurRadius: 0,
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
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: _size.width / 25.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '${'phone'.trArgs()}: $phone',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: _size.width / 26.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _size.width / 26.0,
                    color: colorTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
