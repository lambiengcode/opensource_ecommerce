import 'dart:async';
import 'dart:io';
import 'package:van_transport/src/pages/home/controllers/product_global_controller.dart';
import 'package:van_transport/src/pages/navigation/navigation_page.dart';
import 'package:van_transport/src/pages/splash/splash.dart';
import 'package:van_transport/src/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  static bool firstCome = true;
  static String token;
  static int time = 3;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final productController = Get.put(ProductGlobalController());
  Timer _timmerInstance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> jwt;
  Future<String> locale;

  void startTimmer() {
    var oneSec = Duration(milliseconds: 600);
    _timmerInstance = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (App.time <= 0) {
            _timmerInstance.cancel();
            App.firstCome = false;
          } else {
            App.time--;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
    ));
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    productController.getProduct();
    super.initState();
    if (App.time > 0) {
      startTimmer();
    }
    jwt = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('jwt') != null ? prefs.getString('jwt') : '';
    });

    _prefs.then((SharedPreferences prefs) {
      if (prefs.getString('locale') == 'en') {
        Get.updateLocale(Locale('en', 'US'));
      } else {
        Get.updateLocale(Locale('vi', 'VN'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: jwt,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError) {
              return Loading();
            }

            if (App.token != null) {
            } else {
              if (snapshot.data == '') {
                App.token = '';
              } else {
                App.token = snapshot.data;
              }
            }

            return App.time == 0 ? Navigation() : SplashPage();
        }
      },
    );
  }
}
