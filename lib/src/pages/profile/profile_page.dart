import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/factory/route_factory.dart';
import 'package:van_transport/src/factory/route_type.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  return Container(
                    height: height * .8,
                    width: width,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(colorTitle),
                      ),
                    ),
                  );
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
                          _buildAction(
                            context,
                            'myvoucher'.trArgs(),
                            Feather.tag,
                            mProfile['role'],
                            null,
                          ),
                          _padding(context),
                          _buildAction(
                            context,
                            'mypoints'.trArgs(),
                            Feather.database,
                            mProfile['role'],
                            RouteType.myPoints,
                          ),
                          _padding(context),
                          _buildAction(
                            context,
                            'myFriends'.trArgs(),
                            Feather.users,
                            mProfile['role'],
                            RouteType.myFriends,
                          ),
                          _padding(context),
                          _buildAction(
                            context,
                            'address'.trArgs(),
                            Feather.map_pin,
                            mProfile['role'],
                            RouteType.address,
                          ),
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
                            context,
                            'term'.trArgs(),
                            Feather.help_circle,
                            mProfile['role'],
                            null,
                          ),
                          _padding(context),
                          _buildAction(
                            context,
                            'settings'.trArgs(),
                            Feather.settings,
                            mProfile['role'],
                            RouteType.settings,
                          ),
                          _padding(context),
                          _buildAction(
                            context,
                            'about'.trArgs(),
                            Feather.alert_circle,
                            mProfile['role'],
                            null,
                          ),
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
                            context,
                            'owner'.trArgs(),
                            Feather.shopping_bag,
                            mProfile['role'],
                            null,
                          ),
                          _padding(context),
                          _buildAction(
                            context,
                            'transportOwner'.trArgs(),
                            Feather.truck,
                            mProfile['role'],
                            null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              );
                            },
                            barrierColor: Color(0x80000000),
                            barrierDismissible: false);
                        await _authService.signOut();
                        Get.back();
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

  Widget _buildAction(context, title, icon, role, RouteType routeType) {
    GetSnackBar getSnackBar = GetSnackBar(
      title: 'Sắp ra mắt!',
      subTitle: 'Tính năng đang trong giai đoạn phát triển.',
    );
    return GestureDetector(
      onTap: () {
        if (title == 'mypoints'.trArgs() ||
            title == 'myFriends'.trArgs() ||
            title == 'address'.trArgs() ||
            title == 'settings'.trArgs()) {
          final route = MenuFactory.getRoute(
            routeType,
          );
          Get.toNamed(route.getRoute());
        } else if (title == 'owner'.trArgs()) {
          if (role == 'TRANSPORT_SUB' ||
              role == 'STAFF' ||
              role == 'TRANSPORT') {
            GetSnackBar getSnackBarStaff = GetSnackBar(
              title: 'Không thể truy cập!',
              subTitle: 'Bạn đã là thành viên của đơn vị vận chuyển.',
            );
            getSnackBarStaff.show();
          } else {
            Get.toNamed(
              role == 'ADMIN'
                  ? Routes.ADMIN
                  : Routes.MERCHANT + Routes.MIDDLEWAREMERCHANT,
            );
          }
        } else if (title == 'transportOwner'.trArgs()) {
          if (role == 'TRANSPORT_SUB') {
            Get.toNamed(Routes.SUBTRANSPORT);
          } else if (role == 'STAFF') {
            GetSnackBar getSnackBarStaff = GetSnackBar(
              title: 'Không thể truy cập!',
              subTitle: 'Bạn chưa được giao nhiệm vụ quản lí vận chuyển.',
            );
            getSnackBarStaff.show();
          } else if (role == 'MERCHANT') {
            GetSnackBar getSnackBarStaff = GetSnackBar(
              title: 'Không thể truy cập!',
              subTitle: 'Bạn đang quản lí một cửa hàng.',
            );
            getSnackBarStaff.show();
          } else {
            Get.toNamed(
              role == 'ADMIN'
                  ? Routes.ADMIN
                  : Routes.DELIVERY + Routes.MIDDLETRANSPORT,
            );
          }
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
