import 'dart:io';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:van_transport/src/common/secret_key.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/merchant/controllers/merchant_controller.dart';
import 'package:van_transport/src/pages/transport/widgets/vertical_transport_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:van_transport/src/services/storage_service.dart';

class EditMerchantPage extends StatefulWidget {
  final merchantInfo;
  EditMerchantPage({this.merchantInfo});
  @override
  State<StatefulWidget> createState() => _EditMerchantPageState();
}

class _EditMerchantPageState extends State<EditMerchantPage> {
  final merchantController = Get.put(MerchantController());
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _title, _desc, _address, _phone, _lat, _lng;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  PickResult selectedPlace;
  LocationData currentLocation;

  void showImageBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _chooseImage(context);
      },
    );
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
                                            addressController.text =
                                                selectedPlace.formattedAddress
                                                    .toString();
                                            _address = selectedPlace
                                                .formattedAddress
                                                .toString();
                                            _lat = selectedP
                                                .geometry.location.lat
                                                .toString();
                                            _lng = selectedP
                                                .geometry.location.lng
                                                .toString();
                                          });
                                          Get.back();
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
    _title = widget.merchantInfo['name'];
    _desc = widget.merchantInfo['description'];
    _address = widget.merchantInfo['address']['fullAddress'];
    _phone = widget.merchantInfo['address']['phoneNumber'];
    _lat = widget.merchantInfo['address']['coordinates']['lat'];
    _lng = widget.merchantInfo['address']['coordinates']['lng'];
    titleController.text = widget.merchantInfo['name'];
    descController.text = widget.merchantInfo['description'];
    addressController.text = widget.merchantInfo['address']['fullAddress'];
    phoneController.text = widget.merchantInfo['address']['phoneNumber'];
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
          'Sửa thông tin',
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (_image != null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      },
                      barrierColor: Color(0x80000000),
                      barrierDismissible: false);
                  StorageService storageService = StorageService();
                  String urlToImage =
                      await storageService.uploadImageNotProfile(_image);
                  merchantController.editMerchant(
                    widget.merchantInfo['_id'],
                    _title,
                    _desc,
                    urlToImage,
                    _address,
                    _phone,
                    _lat,
                    _lng,
                  );
                  Get.back();
                } else {
                  Get.back();
                  merchantController.editMerchant(
                    widget.merchantInfo['_id'],
                    _title,
                    _desc,
                    widget.merchantInfo['image'],
                    _address,
                    _phone,
                    _lat,
                    _lng,
                  );
                }
              }
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 12.0),
              GestureDetector(
                onTap: () => showImageBottomSheet(),
                child: VerticalTransportCard(
                  image: _image,
                  address: _address,
                  title: _title,
                  urlToImage: widget.merchantInfo['image'],
                  desc: _desc,
                ),
              ),
              SizedBox(height: 16.0),
              _buildLineInfo(context, 'title'.trArgs(), '', titleController),
              _buildDivider(context),
              _buildLineInfo(
                  context, 'address'.trArgs(), '', addressController),
              _buildDivider(context),
              _buildLineInfo(
                  context, 'description'.trArgs(), '', descController),
              _buildDivider(context),
              _buildLineInfo(context, 'phone'.trArgs(), '', titleController),
              _buildDivider(context),
            ],
          ),
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
              if (title == 'title'.trArgs()) {
                _title = val.trim();
              } else if (title == 'description'.trArgs()) {
                _desc = val.trim();
              } else if (title == 'phone'.trArgs()) {
                _phone = val.trim();
              } else {
                _address = val.trim();
              }
            });
          },
          inputFormatters: title == 'phone'.trArgs()
              ? [
                  FilteringTextInputFormatter.digitsOnly,
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

  Widget _chooseImage(context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            30.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .35),
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
            SizedBox(height: 8.0),
            _buildAction(context, 'capture'.trArgs(), Feather.camera),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(context, 'pickPhoto'.trArgs(), Feather.image),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon) {
    final _size = MediaQuery.of(context).size;

    Future<void> _pickImage(ImageSource source) async {
      File selected = await ImagePicker.pickImage(
        source: source,
        maxHeight: 400.0,
        maxWidth: 400.0,
      );
      if (selected != null) {
        setState(() {
          _image = selected;
        });
        Get.back();
      }
    }

    return GestureDetector(
      onTap: () {
        switch (title) {
          // English
          case 'Take a Photo':
            _pickImage(ImageSource.camera);
            break;
          case 'Choose from Album':
            _pickImage(ImageSource.gallery);
            break;

          // Vietnamese
          case 'Chụp ảnh':
            _pickImage(ImageSource.camera);
            break;
          case 'Chọn ảnh từ Album':
            _pickImage(ImageSource.gallery);
            break;

          default:
            break;
        }
      },
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: _size.width / 16.0,
                  color: Colors.grey.shade800,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _size.width / 22.5,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
