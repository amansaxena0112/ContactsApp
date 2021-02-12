import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:flutter/material.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc _homeBloc = HomeBloc();

  HomeBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static HomeBloc getHomeBloc(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<HomeBlocProvider>())
          ._homeBloc;
}
