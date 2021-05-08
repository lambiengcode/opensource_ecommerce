import 'dart:io';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/transport/widgets/vertical_transport_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/services/storage.dart';
import 'package:van_transport/src/services/transport.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class RegisterTransportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterTransportPageState();
}

class _RegisterTransportPageState extends State<RegisterTransportPage> {
  final _formKey = GlobalKey<FormState>();
  TransportService transportService = TransportService();
  List<String> categories = [
    'Standard',
    'Frozen',
    'Jewelry',
  ];
  File _image;
  File _imageVerify;
  String _title, _desc, _address, _phone;
  bool loading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void showImageBottomSheet(key) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _chooseImage(context, key);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _title = '';
    _desc = '';
    _address = '';
    _phone = '';
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                'Register Company',
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
                      GetSnackBar getSnackBar;
                      if (_image == null) {
                        getSnackBar = GetSnackBar(
                          title: 'Register fail!',
                          subTitle: 'Let\'s choose a image for your company',
                        );
                        getSnackBar.show();
                      } else if (_imageVerify == null) {
                        getSnackBar = GetSnackBar(
                          title: 'Register fail!',
                          subTitle: 'Let\'s choose a corporate documents',
                        );
                        getSnackBar.show();
                      } else {
                        setState(() {
                          loading = true;
                        });
                        StorageService storageService = StorageService();
                        String urlAvatar =
                            await storageService.uploadImageNotProfile(_image);
                        String urlImageVerify = await storageService
                            .uploadImageNotProfile(_imageVerify);
                        var res = await transportService.registerTransport(
                            _title,
                            _desc,
                            urlAvatar,
                            urlImageVerify,
                            _phone,
                            _address);

                        if (res['status'] == 200) {
                          Get.back();
                          GetSnackBar snackBar = GetSnackBar(
                            title: 'Register Successfully!',
                            subTitle: 'Waitting for response from admin.',
                          );
                          snackBar.show();
                        } else {
                          setState(() {
                            loading = false;
                            _title = res['name'];
                            _desc = res['description'];
                            _phone = res['phone'];
                            _address = res['headquarters'];
                            titleController.text = res['name'];
                            descController.text = res['description'];
                            phoneController.text = res['phone'];
                            addressController.text = res['headquarters'];
                          });
                          GetSnackBar snackBar = GetSnackBar(
                            title: 'Register Fail!',
                            subTitle: 'Internal Server Error.',
                          );
                          snackBar.show();
                        }
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
                      onTap: () => showImageBottomSheet('Avatar'),
                      child: VerticalTransportCard(
                        image: _image,
                        address: _address,
                        title: _title,
                        urlToImage: '',
                        desc: _desc,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildLineInfo(
                        context, 'Company Name', '', titleController),
                    _buildDivider(context),
                    _buildLineInfo(
                        context, 'phone'.trArgs(), '', phoneController),
                    _buildDivider(context),
                    _buildLineInfo(
                        context, 'address'.trArgs(), '', addressController),
                    _buildDivider(context),
                    _buildLineInfo(context, 'Description', '', descController),
                    _buildDivider(context),
                    GestureDetector(
                      onTap: () => showImageBottomSheet('Verify'),
                      child: Container(
                        height: height * .155,
                        width: width,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: mC,
                          boxShadow: [
                            BoxShadow(
                              color: mCD,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                            ),
                            BoxShadow(
                              color: mCL,
                              offset: Offset(-5, -5),
                              blurRadius: 5,
                            ),
                          ],
                          image: _imageVerify != null
                              ? DecorationImage(
                                  image: FileImage(_imageVerify),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _imageVerify == null
                              ? 'Upload your corporate documents'
                              : '',
                          style: TextStyle(
                            color: colorDarkGrey,
                            fontSize: width / 28.0,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    // _buildListCategories()
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildListCategories() {
    return Container(
      height: width * .135,
      width: width,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return NeumorphicButton(
            onPressed: () => null,
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(8.0),
              ),
              depth: 4.0,
              intensity: .65,
              color: mC,
            ),
            margin: EdgeInsets.only(right: 12.0, bottom: width / 32.0),
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categories[index],
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontFamily: 'Lato',
                    fontSize: width / 30.0,
                  ),
                ),
              ],
            ),
            duration: Duration(milliseconds: 200),
          );
        },
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 14.0, 4.0),
      child: TextFormField(
        controller: controller,
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: colorTitle,
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) => val.trim().length == 0 ? 'Input value here' : null,
        onChanged: (val) {
          setState(() {
            if (title == 'Company Name') {
              _title = val.trim();
            } else if (title == 'phone'.trArgs()) {
              _phone = val.trim();
            } else if (title == 'address'.trArgs()) {
              _address = val.trim();
            } else {
              _desc = val.trim();
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

  Widget _chooseImage(context, key) {
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
            _buildAction(context, 'capture'.trArgs(), Feather.camera, key),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(context, 'pickPhoto'.trArgs(), Feather.image, key),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon, key) {
    final _size = MediaQuery.of(context).size;

    Future<void> _pickImage(ImageSource source) async {
      File selected = await ImagePicker.pickImage(
        source: source,
        maxHeight: 450.0,
        maxWidth: 450.0,
      );
      if (selected != null) {
        setState(() {
          key == 'Avatar' ? _image = selected : _imageVerify = selected;
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
