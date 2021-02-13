import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/utils/connectivity_util.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:contacts_app/src/utils/network_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBloc extends Object {
  static final DetailBloc _detailBloc = DetailBloc._();
  factory DetailBloc() => _detailBloc;
  DetailBloc._() {
    _networkUtil = NetworkUtil();
    _connectivityUtil = ConnectivityUtil();
    // _snackbarUtil = SnackbarUtil();
    _navigatorUtil = NavigatorUtil();
  }

  NetworkUtil _networkUtil;
  NavigatorUtil _navigatorUtil;
  ConnectivityUtil _connectivityUtil;
  // SnackbarUtil _snackbarUtil;
  List<ContactModel> contactModels = [];

  TextEditingController locationController = TextEditingController();
  TextEditingController carController = TextEditingController();

  BehaviorSubject<ContactModel> _contactModel = BehaviorSubject<ContactModel>();
  BehaviorSubject<int> _index = BehaviorSubject<int>();

  Stream<ContactModel> get contactModel => _contactModel.stream;
  ContactModel get contactModelValue => _contactModel.stream.value;
  Function(ContactModel) get updateContactModel => _contactModel.sink.add;
  Stream<int> get index => _index.stream;
  int get indexValue => _index.stream.value;
  Function(int) get updateIndex => _index.sink.add;

  void dispose() {
    _contactModel.close();
    _index.close();
  }

  void updateContactLocally(bool isFavourite) {
    List<ContactModel> contactModelList = HomeBloc().contactModelListValue;
    ContactModel contact = contactModelList[indexValue];
    contact.favorite = isFavourite;
    HomeBloc().updateContactModelList(contactModelList);
  }

  Future<bool> clearAll() async {
    return true;
  }
}
