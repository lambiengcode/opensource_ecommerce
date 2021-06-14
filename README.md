## UTE2.21-EC18B302-FE - Van Transport Hub

### Description
```text
This is project about transport hub using Flutter for develop mobile application.
```

### How I can run it?

- 🚀 Require flutter version below 2.0
- 🚀 Clone this repo to your pc
- 🚀 run below script in terminal of project

```terminal
flutter pub get
flutter run
```

### Logo brand

<img src="https://github.com/lambiengcode/project_college_ec/blob/master/images/logo_app.png?raw=true" width="150px" height="150px"/>

- Design by lambiengcode

### Screenshots

<p> 
<img src="https://github.com/hongvinhmobile/project_college_ec/blob/dev/screenshots/home.png?raw=true" width="200px"/>
<img src="https://github.com/hongvinhmobile/project_college_ec/blob/dev/screenshots/profile.png?raw=true" width="200px"/>
<img src="https://github.com/hongvinhmobile/project_college_ec/blob/dev/screenshots/details.png?raw=true" width="200px"/>
</p>

### Factory Design Pattern

- Create Enum ***route_type.dart***
```dart
enum RouteType {
  myPoints,
  myFriends,
  address,
  settings,
}
```

- Create Abstract Class - ***route.dart***
```dart
abstract class Route {
  getRoute() {}
}
```

- Create Concrete Class - ***settings_route.dart***, similar with ***friend_route.dart, point_route.dart, address_route.dart***
```dart
import 'package:van_transport/src/models/route.dart';
import 'package:van_transport/src/routes/app_pages.dart';

class SettingsRoute implements Route {
  @override
  getRoute() {
    return Routes.SETTINGS;
  }
}
```

- Create Factory Class - ***food_factory.dart*** 
```dart
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
```

### Author
```text
lambiengcode
```
