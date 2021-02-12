import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/utils/connectivity_util.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:contacts_app/src/utils/network_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddContactBloc extends Object {
  static final AddContactBloc _addContactBloc = AddContactBloc._();
  factory AddContactBloc() => _addContactBloc;
  AddContactBloc._() {
    _networkUtil = NetworkUtil();
    _connectivityUtil = ConnectivityUtil();
    // _snackbarUtil = SnackbarUtil();
    // _commonUtil = CommonUtil();
    _navigatorUtil = NavigatorUtil();
    // _prefsUtil = PrefsUtil();
    // key = new GlobalKey();
    // _notificationUtil = NotificationUtil();
    // _fcmUtil = FcmUtil();
  }

  String imagePath;
  // UserModel _user;
  // BookingModel _bookingModel;
  NetworkUtil _networkUtil;
  NavigatorUtil _navigatorUtil;
  // CommonUtil _commonUtil;
  ConnectivityUtil _connectivityUtil;
  // PrefsUtil _prefsUtil;
  // SnackbarUtil _snackbarUtil;
  List<ContactModel> contactModels = [];

  TextEditingController locationController = TextEditingController();
  TextEditingController carController = TextEditingController();

  BehaviorSubject<ContactModel> _contactModel = BehaviorSubject<ContactModel>();

  Stream<ContactModel> get contactModel => _contactModel.stream;
  ContactModel get contactModelValue => _contactModel.stream.value;
  Function(ContactModel) get updateContactModel => _contactModel.sink.add;

  void dispose() {
    _contactModel.close();
  }

  Future<bool> clearAll() async {
    return true;
  }

  // Future<bool> getContacts(BuildContext context) async {
  //   await _connectivityUtil.init();
  //   if (_connectivityUtil.isConnectionActive) {
  //     try {
  //       http.Response response = await _networkUtil.getContacts();
  //       print(response.body);
  //       if (response.statusCode == 500) {
  //         // _snackbarUtil.updateMessageSignup('Something went wrong!');
  //         return false;
  //       } else if (response.statusCode == 200) {
  //         contactModels = [];
  //         List<dynamic> responseData = json.decode(response.body);
  //         print(responseData);
  //         responseData.forEach((data) {
  //           ContactModel contact = ContactModel.fromMap(data);
  //           contactModels.add(contact);
  //         });
  //         contactModels.sort((a, b) => a.firstName.compareTo(b.firstName));
  //         updateContactModelList(contactModels);
  //         print(contactModelListValue.length);
  //         _navigatorUtil.navigateAndPopScreen(context, '/home');
  //         return true;
  //       } else {
  //         Map<dynamic, dynamic> responseMap = json.decode(response.body);
  //         // if (responseMap['msg'] != null) {
  //         //   _snackbarUtil
  //         //       .updateMessageSignup(responseMap['message'].toString());
  //         // } else {
  //         //   _snackbarUtil.updateMessageSignup(
  //         //       'Unable to reach our server. Check network connection');
  //         // }
  //         return false;
  //       }
  //     } catch (ex, t) {
  //       print(ex);
  //       print(t);
  //       // _snackbarUtil.updateMessageSignup(ex);
  //       return false;
  //     }
  //   } else {
  //     // _snackbarUtil
  //     //     .updateMessageSignup('No network available. Check your connection');
  //     return false;
  //   }
  // }
}
