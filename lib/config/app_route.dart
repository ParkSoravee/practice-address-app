import 'package:flutter/material.dart';

import '../screens/screens.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return HomeScreen.route();
      case ProvinceScreen.routeName:
        return ProvinceScreen.route();
      case AmphureScreen.routeName:
        return AmphureScreen.route();
      case TambonScreen.routeName:
        return TambonScreen.route();
      default:
        return HomeScreen.route();
    }
  }
}
