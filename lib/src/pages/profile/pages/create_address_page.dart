import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';

class CreateAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  final profileController = Get.put(ProfileController());
  String _address;
  String _phone;
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  PickResult selectedPlace;
  LocationData currentLocation;

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
                                            addressController.text = selectedP
                                                .formattedAddress
                                                .toString();
                                            _address = selectedP
                                                .formattedAddress
                                                .toString();
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
    _address = '';
    _phone = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: .0,
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
          'address'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              profileController.addAddress(selectedPlace, _phone);
            },
            icon: Icon(
              Feather.check,
              color: colorPrimary,
              size: width / 16.0,
            ),
          ),
        ],
      ),
      body: Container(
        color: mC,
        child: Column(
          children: [
            SizedBox(height: 12.0),
            _buildLineInfo(context, 'address'.trArgs(), '', addressController),
            _buildDivider(context),
            _buildLineInfo(context, 'phone'.trArgs(), '', phoneController),
            _buildDivider(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (title == 'address'.trArgs()) {
          chooseLocation(context);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(14.0, 18.0, 14.0, 4.0),
        child: TextFormField(
          enabled: title != 'address'.trArgs(),
          controller: controller,
          cursorColor: colorTitle,
          cursorRadius: Radius.circular(30.0),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w500,
          ),
          validator: (val) =>
              val.trim().length == 0 ? 'Input value here' : null,
          onChanged: (val) {
            setState(() {
              if (title == 'address'.trArgs()) {
                _address = val.trim();
              } else {
                _phone = val.trim();
              }
            });
          },
          inputFormatters: title == 'Price - VNĐ'
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) {
                      return newValue.copyWith(text: '');
                    } else if (newValue.text.compareTo(oldValue.text) != 0) {
                      final int selectionIndexFromTheRight =
                          newValue.text.length - newValue.selection.end;
                      final f = NumberFormat("#,###");
                      final number = int.parse(
                          newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
                      final newString = f.format(number);
                      return TextEditingValue(
                        text: newString,
                        selection: TextSelection.collapsed(
                            offset:
                                newString.length - selectionIndexFromTheRight),
                      );
                    } else {
                      return newValue;
                    }
                  })
                ]
              : [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.only(
              left: 12.0,
            ),
            border: InputBorder.none,
            labelText: title,
            labelStyle: TextStyle(
              color: colorTitle,
              fontSize: _size.width / 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(context) {
    return Divider(
      color: Colors.grey.shade400,
      thickness: .25,
      height: .25,
      indent: 25.0,
      endIndent: 25.0,
    );
  }
}
