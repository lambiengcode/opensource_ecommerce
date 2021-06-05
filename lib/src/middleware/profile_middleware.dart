import 'package:flutter/material.dart';
import 'package:van_transport/src/app.dart';
import 'package:van_transport/src/pages/authentication/authentication_page.dart';
import 'package:van_transport/src/pages/profile/profile_page.dart';

class ProfileMiddleware extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileMiddlewareState();
}

class _ProfileMiddlewareState extends State<ProfileMiddleware> {
  @override
  Widget build(BuildContext context) {
    return App.token != '' ? ProfilePage() : AuthenticatePage();
  }
}
