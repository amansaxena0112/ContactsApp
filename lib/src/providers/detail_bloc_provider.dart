import 'package:contacts_app/src/blocs/detail_bloc.dart';
import 'package:flutter/material.dart';

class DetailBlocProvider extends InheritedWidget {
  final DetailBloc _detailBloc = DetailBloc();

  DetailBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static DetailBloc getDetailBloc(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<DetailBlocProvider>())
          ._detailBloc;
}
