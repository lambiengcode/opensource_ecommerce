import 'package:delivery_hub/src/common/style.dart';
import 'package:delivery_hub/src/models/action.dart';
import 'package:delivery_hub/src/pages/home/widget/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationData currentLocation;
  Future<dynamic> _myLocation;

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
    result = result.replaceAll(first.adminArea, '');
    result = result.replaceAll(first.countryName, '');
    return result;
  }

  @override
  void initState() {
    super.initState();
    _myLocation = getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: _size.height / 22.0),
            _buildTopBar(context),
            SizedBox(height: 12.0),
            Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHorizontalAction(context),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed('/address'),
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 12.5),
                      Icon(
                        Feather.target,
                        color: colorPrimary,
                        size: _size.width / 16.0,
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'deliver'.trArgs(),
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: _size.width / 22.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          FutureBuilder(
                            future: _myLocation,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Text(
                                    'Thành Phố Hồ Chí Minh, Việt Nam',
                                    style: TextStyle(
                                      color: colorTitle,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                default:
                                  if (snapshot.hasError) {
                                    return Text(
                                      'Thành Phố Hồ Chí Minh, Việt Nam',
                                      style: TextStyle(
                                        color: colorTitle,
                                        fontSize: _size.width / 26.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  }

                                  return Text(
                                    snapshot.data.toString().substring(
                                            0,
                                            snapshot.data.toString().length -
                                                7) +
                                        '...',
                                    style: TextStyle(
                                      color: colorTitle,
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.toNamed('/address'),
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: _size.width / 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: () => Get.toNamed('/category'),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              color: mC,
              boxShadow: [
                BoxShadow(
                  color: mCD,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: mCL,
                  offset: Offset(-4, -4),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 16.0,
              right: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Feather.search,
                      size: _size.width / 21.5,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'searchHide'.trArgs(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: _size.width / 26.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
                Icon(
                  Feather.list,
                  size: _size.width / 20.0,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalAction(context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(2.0, .0, 2.0, 4.0),
      height: _size.width * .25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return ActionButton(
            index: index,
            title: actions[index].title,
            icon: actions[index].icon,
          );
        },
      ),
    );
  }
}
