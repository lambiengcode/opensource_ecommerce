import 'package:ecommerce_ec/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Add Info Product'.trArgs(),
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
                      height: width * .08,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildProductCardImage(),
                          _buildProductCardImage(),
                          _buildProductCardNoImage(),
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
            _buildAddressValue('Weight', '2 Kg'),
            SizedBox(height: 18.0),
            _buildAddressValue('Type Product', 'Pick Type'),
            SizedBox(height: 24.0),
            NeumorphicButton(
              onPressed: () => Get.back(),
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
                      'Add to Order',
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
        Text(
          value,
          style: TextStyle(
            color: value == 'Pick Type' ? colorPrimary : colorTitle,
            fontSize: width / 24.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCardImage() {
    return Container(
      height: width * .26,
      width: width * .26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colorPrimary, width: 3.0),
      ),
      alignment: Alignment.center,
      child: Container(
        height: width * .235,
        width: width * .235,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1598313697935-b4d757c226c2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8c2hvZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCardNoImage() {
    return Container(
      height: width * .26,
      width: width * .26,
      child: NeumorphicButton(
        onPressed: () => null,
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
}
