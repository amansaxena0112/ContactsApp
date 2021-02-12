import 'package:contacts_app/src/blocs/add_contact_bloc.dart';
import 'package:flutter/material.dart';

class AddContactBlocProvider extends InheritedWidget {
  final AddContactBloc _addContactBloc = AddContactBloc();

  AddContactBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AddContactBloc getAddContacBloc(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<AddContactBlocProvider>())
          ._addContactBloc;
}
