import 'dart:io';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/transport/controllers/transport_controller.dart';
import 'package:van_transport/src/pages/transport/widgets/bottom_sheet_set_price.dart';
import 'package:van_transport/src/pages/transport/widgets/vertical_transport_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:van_transport/src/services/storage_service.dart';

class EditTransportPage extends StatefulWidget {
  final transportInfo;
  EditTransportPage({@required this.transportInfo});
  @override
  State<StatefulWidget> createState() => _EditTransportPageState();
}

class _EditTransportPageState extends State<EditTransportPage> {
  final transportController = Get.put(TransportController());
  final formKey = GlobalKey<FormState>();
  List<String> categories = [
    'Standard',
    'Frozen',
    'Jewelry',
  ];
  File _image;
  String _title, _desc, _address, _phone;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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

  showSetPriceBottomSheet(title, data) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSetPrice(
          title: title,
          data: data,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.transportInfo['headquarters']);
    transportController.getTransport();
    _title = widget.transportInfo['name'];
    _desc = widget.transportInfo['description'];
    _address = widget.transportInfo['headquarters'];
    _phone = widget.transportInfo['phone'];
    titleController.text = widget.transportInfo['name'];
    descController.text = widget.transportInfo['description'];
    addressController.text = widget.transportInfo['headquarters'];
    phoneController.text = widget.transportInfo['phone'];
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
              if (formKey.currentState.validate()) {
                if (_image == null) {
                  transportController.editTransport(
                    widget.transportInfo['_id'],
                    _title,
                    _desc,
                    widget.transportInfo['avatar'],
                    _phone,
                    _address,
                  );
                } else {
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
                  transportController.editTransport(
                    widget.transportInfo['_id'],
                    _title,
                    _desc,
                    urlToImage,
                    _phone,
                    _address,
                  );
                  Get.back();
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
          key: formKey,
          child: StreamBuilder(
            stream: transportController.getTransportStream,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Column(
                children: [
                  SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: () => showImageBottomSheet(),
                    child: VerticalTransportCard(
                      image: _image,
                      address: _address,
                      title: _title,
                      urlToImage: widget.transportInfo['avatar'],
                      desc: _desc,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _buildLineInfo(context, 'Company Name', '', titleController),
                  _buildDivider(context),
                  _buildLineInfo(
                      context, 'phone'.trArgs(), '', phoneController),
                  _buildDivider(context),
                  _buildLineInfo(
                      context, 'address'.trArgs(), '', addressController),
                  _buildDivider(context),
                  _buildLineInfo(
                      context, 'description'.trArgs(), '', descController),
                  _buildDivider(context),
                  SizedBox(height: 24.0),
                  _buildListCategories(
                    snapshot.data['typeSupport'],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListCategories(listPrices) {
    return Container(
      height: width * .135,
      width: width,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        itemCount: listPrices.length,
        itemBuilder: (context, index) {
          return NeumorphicButton(
            onPressed: () => showSetPriceBottomSheet(
              categories[index],
              listPrices[index],
            ),
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
