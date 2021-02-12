import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:flutter/material.dart';

import './app_routes.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return HomeBlocProvider(
      child: ContactsApp(),
    );
  }
}

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.routes,
      theme: new ThemeData(
        fontFamily: "MetropolisMedium",
        primaryColor: Colors.cyan,
        primaryTextTheme:
            TextTheme(headline1: TextStyle(color: Colors.tealAccent)),
        primaryIconTheme: IconThemeData(color: Colors.tealAccent),
      ),
    );
  }
}
