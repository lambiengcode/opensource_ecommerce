import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/profile/controllers/profile_controller.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/services/authentication_service.dart';
import 'package:van_transport/src/widgets/error_loading_image.dart';
import 'package:van_transport/src/widgets/place_holder_image.dart';
import 'package:van_transport/src/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
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
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mC,
        height: height,
        width: width,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: StreamBuilder(
              stream: profileController.getProfileController,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                var mProfile = snapshot.data;

                return Column(
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
                          SizedBox(height: 4.0),
                          GestureDetector(
                            onTap: () =>
                                Get.toNamed(Routes.EDITPROFILE, arguments: {
                              'image': mProfile['image'],
                              'fullName': mProfile['fullName'],
                              'phone': mProfile['phone'],
                              'email': mProfile['email'],
                              'createdAt': mProfile['createdAt'],
                              'point': mProfile['point'],
                              'role': mProfile['role'],
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(1000.0),
                                      child: CachedNetworkImage(
                                        width: _size.width * .315,
                                        height: _size.width * .315,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            PlaceHolderImage(),
                                        errorWidget: (context, url, error) =>
                                            ErrorLoadingImage(),
                                        imageUrl: mProfile['image'],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      mProfile['fullName'],
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
                          SizedBox(height: 4.0),
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
                          _buildAction(context, 'myvoucher'.trArgs(),
                              Feather.tag, mProfile['role']),
                          _padding(context),
                          _buildAction(context, 'mypoints'.trArgs(),
                              Feather.database, mProfile['role']),
                          _padding(context),
                          _buildAction(context, 'myFriends'.trArgs(),
                              Feather.users, mProfile['role']),
                          _padding(context),
                          _buildAction(context, 'address'.trArgs(),
                              Feather.map_pin, mProfile['role']),
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
                          _buildAction(context, 'term'.trArgs(),
                              Feather.help_circle, mProfile['role']),
                          _padding(context),
                          _buildAction(context, 'settings'.trArgs(),
                              Feather.settings, mProfile['role']),
                          _padding(context),
                          _buildAction(context, 'about'.trArgs(),
                              Feather.alert_circle, mProfile['role']),
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
                          _buildAction(context, 'owner'.trArgs(),
                              Feather.shopping_bag, mProfile['role']),
                          _padding(context),
                          _buildAction(context, 'transportOwner'.trArgs(),
                              Feather.truck, mProfile['role']),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    GestureDetector(
                      onTap: () async {
                        await _authService.signOut();
                        Get.offAndToNamed('/root');
                      },
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
                                color: colorPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 42.0),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

//m
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

  Widget _buildAction(context, title, icon, role) {
    GetSnackBar getSnackBar = GetSnackBar(
      title: 'Comming Soon!',
      subTitle: 'This feature will available in next update',
    );
    return GestureDetector(
      onTap: () {
        if (title == 'mypoints'.trArgs()) {
          Get.toNamed(Routes.POINT);
        } else if (title == 'myFriends'.trArgs()) {
          Get.toNamed(Routes.MYFRIENDS);
        } else if (title == 'address'.trArgs()) {
          Get.toNamed(Routes.ADDRESS);
        } else if (title == 'settings'.trArgs()) {
          Get.toNamed(Routes.SETTINGS);
        } else if (title == 'owner'.trArgs()) {
          Get.toNamed(
            role == 'ADMIN'
                ? Routes.ADMIN
                : Routes.MERCHANT + Routes.MIDDLEWAREMERCHANT,
          );
        } else if (title == 'transportOwner'.trArgs()) {
          Get.toNamed(
            role == 'ADMIN'
                ? Routes.ADMIN
                : Routes.DELIVERY + Routes.MIDDLETRANSPORT,
          );
        } else {
          getSnackBar.show();
        }
      },
      child: Container(
        width: width,
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
                  size: width / 18.0,
                  color: Colors.grey.shade700,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: width / 24.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Icon(
              Feather.arrow_right,
              size: width / 18.0,
              color: fCD,
            ),
          ],
        ),
      ),
    );
  }
}
