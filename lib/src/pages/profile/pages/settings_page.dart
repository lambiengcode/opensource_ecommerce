import 'dart:ui';

import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/pages/profile/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: mC,
        elevation: .0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Feather.arrow_left,
            color: colorTitle,
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'settings'.trArgs(),
          style: TextStyle(
            color: colorTitle,
            fontSize: _size.width / 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Container(
        color: mC,
        padding: const EdgeInsets.all(24),
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (_) => Column(
            children: [
              GestureDetector(
                onTap: () =>
                    Get.find<SettingsController>().updateNotification(),
                child: NMCard(
                  active: _.notification,
                  icon: Icons.notifications_on_rounded,
                  label: 'notifications'.trArgs(),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;

                  if (Get.locale == Locale('vi', 'VN')) {
                    Get.updateLocale(Locale('en', 'US'));
                    prefs.setString('locale', 'en').then((bool success) {
                      return 'en';
                    });
                  } else {
                    Get.updateLocale(Locale('vi', 'VN'));
                    prefs.setString('locale', 'vi').then((bool success) {
                      return 'vi';
                    });
                  }
                },
                child: NMCard(
                  active: Get.locale == Locale('vi', 'VN'),
                  icon: Icons.language_sharp,
                  label: 'vietnamese'.trArgs(),
                ),
              ),
              SizedBox(height: 24.0),
              GestureDetector(
                onTap: () => Get.toNamed('/settings/changepsw'),
                child: Container(
                  height: 52.0,
                  width: _size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
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
                        Feather.unlock,
                        color: colorPrimary,
                        size: 16.0,
                      ),
                      SizedBox(width: 8.0),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          'changePsw'.trArgs(),
                          style: TextStyle(
                            fontSize: 14.5,
                            color: colorPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 36.0),
            ],
          ),
        ),
      ),
    );
  }
}

class NMCard extends StatelessWidget {
  final bool active;
  final IconData icon;
  final String label;
  const NMCard({this.active, this.icon, this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: nMbox,
      child: Row(
        children: <Widget>[
          Icon(icon, color: fCL),
          SizedBox(width: 15),
          Text(
            label,
            style: TextStyle(
              color: fCD,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
          Spacer(),
          Container(
            decoration: active ? nMboxInvertActive : nMboxInvert,
            width: 64.0,
            height: 36.0,
            child: Container(
              margin: active
                  ? EdgeInsets.fromLTRB(35, 5, 5, 5)
                  : EdgeInsets.fromLTRB(5, 5, 35, 5),
              decoration: nMbtn,
            ),
          ),
        ],
      ),
    );
  }
}
