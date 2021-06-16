import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/pages/revenue_page.dart';
import 'package:van_transport/src/pages/sub_city/pages/manage_staff_page.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/pages/transport/pages/manage_order_page.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class TransportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportPage();
}

class _TransportPage extends State<TransportPage>
    with SingleTickerProviderStateMixin {
  final transportController = Get.put(TransportController());
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFloatingButton = true;
  bool _createSubTransport = false;

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
                                        onPressed: () async {
                                          final coordinates = new Coordinates(
                                            selectedP.geometry.location.lat,
                                            selectedP.geometry.location.lng,
                                          );
                                          final addresses = await Geocoder.local
                                              .findAddressesFromCoordinates(
                                                  coordinates);
                                          final first = addresses.first;
                                          transportController
                                              .createSubTransport(
                                            first.locality,
                                            selectedP.geometry.location.lat
                                                .toString(),
                                            selectedP.geometry.location.lng
                                                .toString(),
                                            selectedP.formattedAddress
                                                .toString(),
                                          );
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

  var _pages = [
    TransportManageOrderPage(pageName: 'ON_GOING'),
    TransportManageOrderPage(pageName: 'CANCEL'),
    TransportManageOrderPage(pageName: 'RECEIVE'),
    ManageStaffPage(),
    RevenuePage(comeFrom: 'TRANSPORT'),
  ];

  @override
  void initState() {
    super.initState();
    transportController.getTransport();
    _tabController = new TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      if (_tabController.index != 4) {
        setState(() {
          _showFloatingButton = true;
          _tabController.index != 3
              ? _createSubTransport = false
              : _createSubTransport = true;
        });
      } else {
        setState(() {
          _showFloatingButton = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: _showFloatingButton
          ? Container(
              height: width / 6.25,
              width: width / 6.25,
              child: FloatingActionButton(
                backgroundColor: colorTitle,
                child: Icon(
                  Feather.plus,
                  color: colorPrimaryTextOpacity,
                  size: width / 16.0,
                ),
                onPressed: () {
                  if (_createSubTransport) {
                    Get.toNamed(Routes.SUBCITY + Routes.REGISTERSTAFF);
                  } else {
                    chooseLocation(context);
                  }
                },
              ),
            )
          : null,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: 1.5,
        centerTitle: true,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 15.0,
          ),
        ),
        title: Text(
          'transportOwner'
              .trArgs()
              .replaceAll('For ', '')
              .replaceAll('Cho c', 'C'),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          StreamBuilder(
            stream: transportController.getTransportStream,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return IconButton(
                  onPressed: () => null,
                  icon: Icon(
                    Feather.edit_3,
                    color: colorTitle,
                    size: width / 16.0,
                  ),
                );
              }

              return IconButton(
                onPressed: () => Get.toNamed(
                  Routes.DELIVERY + Routes.EDITDELIVERY,
                  arguments: snapshot.data,
                ),
                icon: Icon(
                  Feather.edit_3,
                  color: colorTitle,
                  size: width / 16.0,
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: colorPrimary,
          indicatorColor: colorPrimary,
          unselectedLabelColor: colorTitle.withOpacity(.825),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 1.75,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width / 28.5,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width / 28.5,
          ),
          tabs: [
            Container(
              width: width * .185,
              child: Tab(
                text: 'onGoing'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'reject'.trArgs(),
              ),
            ),
            Container(
              width: width * .13,
              child: Tab(
                text: 'history'.trArgs(),
              ),
            ),
            Container(
              width: Get.locale == Locale('vi', 'VN')
                  ? width * .265
                  : width * .305,
              child: Tab(
                text: 'manageStaff'.trArgs(),
              ),
            ),
            Container(
              width: width * .18,
              child: Tab(
                text: 'statistics'.trArgs(),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages.map((Widget tab) {
          return tab;
        }).toList(),
      ),
    );
  }
}
