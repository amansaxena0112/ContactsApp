import 'package:flutter/material.dart';

import '../src/screens/splash_screen.dart';
import '../src/screens/home_screen.dart';
import '../src/screens/detail_screen.dart';
import '../src/screens/add_contact_screen.dart';

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
      case '/detail':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return DetailScreen();
          },
        );
        break;
      case '/add-contact':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return AddContactScreen();
          },
        );
        break;
      default:
        return null;
    }
  }
}
