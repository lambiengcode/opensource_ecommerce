import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:van_transport/src/pages/order/controllers/cart_client_controller.dart';
import 'package:van_transport/src/pages/order/widgets/bottom_sheet_input_weight.dart';
import 'package:van_transport/src/pages/order/widgets/bottom_sheet_product_type.dart';
import 'package:van_transport/src/services/storage_service.dart';
import 'package:van_transport/src/widgets/snackbar.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final cartController = Get.put(CartClientController());
  List<String> valueOfProductType = [
    'standard'.trArgs(),
    'frozen'.trArgs(),
    'jewelry'.trArgs()
  ];
  List<File> images = [];
  String name = '';
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mCL,
        elevation: .0,
        centerTitle: true,
        leadingWidth: 62.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: width / 16.5,
          ),
        ),
        title: Text(
          'addInfoProduct'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mCL,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.only(top: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50.0),
                  ),
                  color: mCM.withOpacity(.85),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width * .045,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: mC,
                        boxShadow: [
                          BoxShadow(
                            color: mCD,
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                          BoxShadow(
                            color: mCL,
                            offset: Offset(-2, -2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        focusNode: focusNode,
                        onFieldSubmitted: (val) {
                          focusNode.unfocus();
                        },
                        cursorColor: fCL,
                        cursorRadius: Radius.circular(4.0),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: colorTitle,
                          fontSize: width / 26.0,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val.trim();
                          });
                        },
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 24.0,
                          ),
                          border: InputBorder.none,
                          hintText: "Nhập tên...",
                          hintStyle: TextStyle(
                            color: fCL,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          images.length >= 1
                              ? _buildProductCardImage(0)
                              : _buildProductCardNoImage(0),
                          images.length >= 2
                              ? _buildProductCardImage(1)
                              : _buildProductCardNoImage(1),
                          images.length >= 3
                              ? _buildProductCardImage(2)
                              : _buildProductCardNoImage(2),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomCheckout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCheckout(context) {
    return Container(
      color: mCM,
      child: Neumorphic(
        padding: EdgeInsets.fromLTRB(32.0, 32.0, 24.0, 32.0),
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
          depth: -20.0,
          intensity: .6,
          color: mCH.withOpacity(.12),
        ),
        child: Column(
          children: [
            GetBuilder<CartClientController>(
              builder: (_) => _buildAddressValue('weight'.trArgs(),
                  _.weight == null ? 'inputWeight'.trArgs() : _.weight),
            ),
            SizedBox(height: 18.0),
            GetBuilder<CartClientController>(
              builder: (_) => _buildAddressValue(
                  'typeProduct'.trArgs(), valueOfProductType[_.typeProduct]),
            ),
            SizedBox(height: 24.0),
            NeumorphicButton(
              onPressed: () async {
                if (images.length == 0) {
                  GetSnackBar getSnackBar = GetSnackBar(
                    title: 'Không thể thêm sản phẩm',
                    subTitle: 'Hãy tải lên ít nhất 1 hình ảnh',
                  );
                  getSnackBar.show();
                } else if (cartController.weight == null) {
                  GetSnackBar getSnackBar = GetSnackBar(
                    title: 'Không thể thêm sản phẩm',
                    subTitle: 'Hãy nhập khối lượng của sản phẩm!',
                  );
                  getSnackBar.show();
                } else if (name == null) {
                  GetSnackBar getSnackBar = GetSnackBar(
                    title: 'Không thể thêm sản phẩm',
                    subTitle: 'Hãy nhập tên của sản phẩm!',
                  );
                  getSnackBar.show();
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
                  List<String> urls = [];
                  StorageService storageService = StorageService();
                  for (int index = 0; index < images.length; index++) {
                    var url = await storageService
                        .uploadImageNotProfile(images[index]);
                    urls.add(url);
                  }
                  Get.back();
                  cartController.addProductToCart(name, urls);
                }
              },
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(20.0),
                ),
                depth: 15.0,
                intensity: 1,
                color: colorPrimary.withOpacity(.85),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 28.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Feather.clipboard,
                    color: mC,
                    size: width / 18.0,
                  ),
                  SizedBox(width: 12.0),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5),
                    child: Text(
                      'addToOrder'.trArgs(),
                      style: TextStyle(
                        color: mC,
                        fontSize: width / 26.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildAddressValue(title, value) {
    showProductTypeBottomSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return title == 'typeProduct'.trArgs()
              ? BottomProductType(
                  values: valueOfProductType,
                )
              : BottomInputWeight();
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorTitle,
            fontSize: width / 24.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            focusNode.unfocus();
            if (title == 'typeProduct'.trArgs()) showProductTypeBottomSheet();
            if (title == 'weight'.trArgs()) showProductTypeBottomSheet();
          },
          child: Text(
            value,
            style: TextStyle(
              color: title == 'typeProduct'.trArgs() ||
                      value == 'inputWeight'.trArgs()
                  ? colorPrimary
                  : colorTitle,
              fontSize: width / 22.5,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCardImage(index) {
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
          return _chooseImage(context, index);
        },
      );
    }

    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
        showImageBottomSheet();
      },
      child: Container(
        height: width * .26,
        width: width * .26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: colorPrimary, width: 3.0),
        ),
        alignment: Alignment.center,
        child: Container(
          height: width * .235,
          width: width * .235,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: FileImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCardNoImage(index) {
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
          return _chooseImage(context, index);
        },
      );
    }

    return Container(
      height: width * .26,
      width: width * .26,
      child: NeumorphicButton(
        onPressed: () {
          focusNode.unfocus();
          showImageBottomSheet();
        },
        duration: Duration(milliseconds: 100),
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(8.0),
          ),
          depth: 2.5,
          intensity: 1,
          color: mC,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 28.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Feather.image,
              color: colorPrimary,
              size: width / 12.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _chooseImage(context, index) {
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
            _buildAction(context, 'capture'.trArgs(), Feather.camera, index),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(context, 'pickPhoto'.trArgs(), Feather.image, index),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon, index) {
    final _size = MediaQuery.of(context).size;

    Future<void> _pickImage(ImageSource source) async {
      File selected = await ImagePicker.pickImage(
        source: source,
        maxHeight: 400.0,
        maxWidth: 400.0,
      );
      if (selected != null) {
        setState(() {
          if (images.length < 3) {
            images.add(selected);
          } else {
            images[index] = selected;
          }
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
