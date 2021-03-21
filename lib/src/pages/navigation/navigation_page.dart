import 'package:delivery_hub/src/common/style.dart';
import 'package:delivery_hub/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentPage = 0;
  var _pages = [
    HomePage(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: mC,
        child: Stack(
          children: [
            _pages[_currentPage],
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: _size.height * .07,
                width: _size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: _size.height / 30.0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: mC,
                  boxShadow: [
                    BoxShadow(
                      color: mCD,
                      offset: Offset(8, 8),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: mCL,
                      offset: Offset(-4, -4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionNavigation(
                      context,
                      'Home',
                      Feather.home,
                      0,
                    ),
                    _buildActionNavigation(
                      context,
                      'Orders',
                      Feather.clipboard,
                      1,
                    ),
                    _buildActionNavigation(
                      context,
                      'Favourites',
                      Feather.heart,
                      2,
                    ),
                    _buildActionNavigation(
                      context,
                      'Profile',
                      Feather.user,
                      3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionNavigation(context, title, icon, index) {
    final _size = MediaQuery.of(context).size;
    return IconButton(
      icon: Icon(
        icon,
        size: _size.width / 16.96,
        color: _currentPage == index ? colorPrimary : colorDarkGrey,
      ),
      onPressed: () {
        setState(() {
          _currentPage = index;
        });
      },
    );
  }
}
