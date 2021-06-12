import 'package:van_transport/src/factory/route_type.dart';
import 'package:van_transport/src/models/address_route.dart';
import 'package:van_transport/src/models/friend_route.dart';
import 'package:van_transport/src/models/point_route.dart';
import 'package:van_transport/src/models/route.dart';
import 'package:van_transport/src/models/settings_route.dart';

class MenuFactory {
  static Route getRoute(RouteType type) {
    switch (type) {
      case RouteType.myPoints:
        return PointRoute();
      case RouteType.myFriends:
        return FriendRoute();
      case RouteType.address:
        return AddressRoute();
      case RouteType.settings:
        return SettingsRoute();
      default:
        return PointRoute();
    }
  }
}
