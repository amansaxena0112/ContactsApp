import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/utils/connectivity_util.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:contacts_app/src/utils/network_util.dart';
import 'package:contacts_app/src/utils/snackbar_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeBloc extends Object {
  static final HomeBloc _homeBloc = HomeBloc._();
  factory HomeBloc() => _homeBloc;
  HomeBloc._() {
    _networkUtil = NetworkUtil();
    _connectivityUtil = ConnectivityUtil();
    _snackbarUtil = SnackbarUtil();
    _navigatorUtil = NavigatorUtil();
  }

  NetworkUtil _networkUtil;
  NavigatorUtil _navigatorUtil;
  ConnectivityUtil _connectivityUtil;
  SnackbarUtil _snackbarUtil;
  List<String> alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  List<ContactModel> contactModels = [];

  TextEditingController locationController = TextEditingController();
  TextEditingController carController = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  BehaviorSubject<List<ContactModel>> _contactModelList =
      BehaviorSubject<List<ContactModel>>.seeded([]);

  Stream<List<ContactModel>> get contactModelList => _contactModelList.stream;
  List<ContactModel> get contactModelListValue =>
      _contactModelList.stream.value;
  Function(List<ContactModel>) get updateContactModelList =>
      _contactModelList.sink.add;

  void dispose() {
    _contactModelList.close();
  }

  Future<bool> clearAll() async {
    return true;
  }

  void filterList(String searchWord) {
    int index = contactModelListValue
        .indexWhere((element) => element.firstName.startsWith(searchWord));
    print(index);
    if (index != -1) {
      itemScrollController.scrollTo(
          index: index,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOutCubic);
    }
  }

  Future<bool> getContacts(BuildContext context) async {
    await _connectivityUtil.init();
    if (_connectivityUtil.isConnectionActive) {
      try {
        http.Response response = await _networkUtil.getContacts();
        print(response.body);
        if (response.statusCode == 500) {
          _snackbarUtil.updateMessageHome('Something went wrong!');
          return false;
        } else if (response.statusCode == 200) {
          contactModels = [];
          List<dynamic> responseData = json.decode(response.body);
          print(responseData);
          responseData.forEach((data) {
            ContactModel contact = ContactModel.fromMap(data);
            contactModels.add(contact);
          });
          contactModels.sort((a, b) => a.firstName.compareTo(b.firstName));
          updateContactModelList(contactModels);
          print(contactModelListValue.length);
          _navigatorUtil.navigateAndPopScreen(context, '/home');
          return true;
        } else {
          _snackbarUtil.updateMessageHome(response.body);
          return false;
        }
      } catch (ex, t) {
        print(ex);
        print(t);
        return false;
      }
    } else {
      _snackbarUtil
          .updateMessageHome('No network available. Check your connection');
      return false;
    }
  }
}
