import 'package:flutter/material.dart';

import '../src/screens/splash_screen.dart';
import '../src/screens/home_screen.dart';

class AppRoutes {
  static Route routes(RouteSettings settings) {
    String name = settings.name;

    switch (name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return SplashScreen();
          },
        );
        break;
      case '/home':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen();
          },
        );
        break;
      default:
        return null;
    }
  }
}
