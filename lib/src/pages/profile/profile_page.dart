import 'dart:ui';
import 'package:delivery_hub/src/common/style.dart';
import 'package:delivery_hub/src/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        brightness: Brightness.light,
        backgroundColor: mC,
        centerTitle: true,
        title: Text(
          'me'.trArgs(),
          style: TextStyle(
            fontSize: _size.width / 21.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      body: Container(
        color: mC,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: _size.width * .315,
                                  width: _size.width * .315,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mCD,
                                    boxShadow: [
                                      BoxShadow(
                                          color: mCL,
                                          offset: Offset(3, 3),
                                          blurRadius: 3,
                                          spreadRadius: -3),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://avatars.githubusercontent.com/u/60530946?s=460&u=e342f079ed3571122e21b42eedd0ae251a9d91ce&v=4'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  'lambiengcode',
                                  style: TextStyle(
                                    fontSize: _size.width / 22.5,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
                //SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
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
                  child: Column(
                    children: [
                      _buildAction(context, 'myvoucher'.trArgs(), Feather.tag),
                      _padding(context),
                      _buildAction(
                          context, 'mypoints'.trArgs(), Feather.database),
                      _padding(context),
                      _buildAction(
                          context, 'payment'.trArgs(), Feather.credit_card),
                      _padding(context),
                      _buildAction(
                          context, 'address'.trArgs(), Feather.map_pin),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
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
                  child: Column(
                    children: [
                      _buildAction(
                          context, 'owner'.trArgs(), Feather.shopping_bag),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
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
                  child: Column(
                    children: [
                      _buildAction(
                          context, 'term'.trArgs(), Feather.help_circle),
                      _padding(context),
                      _buildAction(
                          context, 'settings'.trArgs(), Feather.settings),
                      _padding(context),
                      _buildAction(
                          context, 'about'.trArgs(), Feather.alert_circle),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    height: 46.8,
                    width: _size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 46.0,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Feather.log_out,
                          color: colorPrimary,
                          size: _size.width / 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'logout'.trArgs(),
                          style: TextStyle(
                            fontSize: _size.width / 28.0,
                            color: colorTitle,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 42.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _padding(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        indent: 25.0,
        endIndent: 25.0,
        thickness: .25,
        height: .25,
        color: Colors.transparent,
      ),
    );
  }

  Widget _buildAction(context, title, icon) {
    final _size = MediaQuery.of(context).size;
    // GetSnackBar getSnackBar = GetSnackBar(
    //   title: 'Comming Soon!',
    //   subTitle: 'This feature will available in next update',
    //   size: _size,
    // );
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(24.0, 10.5, 20.0, 10.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: _size.width / 18.0,
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _size.width / 24.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Icon(
              Feather.arrow_right,
              size: _size.width / 18.0,
              color: fCD,
            ),
          ],
        ),
      ),
    );
  }
}
