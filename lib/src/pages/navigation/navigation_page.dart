import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/common/style.dart';
import 'package:van_transport/src/middleware/profile_middleware.dart';
import 'package:van_transport/src/pages/favourite/favourite_page.dart';
import 'package:van_transport/src/pages/home/home_page.dart';
import 'package:van_transport/src/pages/notifications/notifications_page.dart';
import 'package:van_transport/src/pages/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 2;
  var _pages = [
    OrderPage(),
    FavouritePage(),
    HomePage(),
    NotificationsPage(),
    ProfileMiddleware(),
  ];

  @override
  void initState() {
    print(App.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StyleProvider(
        style: Style(),
        child: ConvexAppBar.badge(
          {3: currentPage == 3 ? '' : '2'},
          initialActiveIndex: 2,
          height: 60.0,
          top: -24.0,
          curveSize: 85.0,
          style: TabStyle.reactCircle,
          activeColor: colorTitle,
          color: colorTitle,
          items: [
            TabItem(icon: Feather.clipboard),
            TabItem(icon: Feather.heart),
            TabItem(icon: Feather.home),
            TabItem(icon: Feather.bell),
            TabItem(icon: Feather.user),
          ],
          backgroundColor: mC,
          onTap: (int i) {
            setState(() {
              currentPage = i;
            });
          },
        ),
      ),
      body: _pages[currentPage],
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 25.0;

  @override
  double get activeIconMargin => 10.0;

  @override
  double get iconSize => 25.0;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10.0, color: color);
  }
}
