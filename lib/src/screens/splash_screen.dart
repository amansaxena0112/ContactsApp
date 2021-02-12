import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeBlocProvider(
      child: SplashDetailsBase(),
    );
  }
}

class SplashDetailsBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashDetails(),
    );
  }
}

class SplashDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = HomeBlocProvider.getHomeBloc(context);
    homeBloc.getContacts(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.grey.withOpacity(0.0),
            Colors.black,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Center(
        child: SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/splash_logo.png',
          ),
        ),
      ),
    );
  }
}
