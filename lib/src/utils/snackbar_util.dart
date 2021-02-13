import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/app_message.dart';

class SnackbarUtil {
  static final SnackbarUtil _snackbarUtil = SnackbarUtil._();
  factory SnackbarUtil() => _snackbarUtil;
  SnackbarUtil._() {
    _messageHome.listen((data) {
      _showSnackbar(_buildContextHome, data);
    });
    _messageAddContact.listen((data) {
      _showSnackbar(_buildContextAddContact, data);
    });
  }

  BuildContext _buildContextHome;
  BuildContext _buildContextAddContact;
  set buildContextHome(BuildContext context) => _buildContextHome = context;
  set buildContextAddContact(BuildContext context) =>
      _buildContextAddContact = context;

  final BehaviorSubject<String> _messageHome = BehaviorSubject<String>();
  Function(String) get updateMessageHome => _messageHome.sink.add;
  final BehaviorSubject<String> _messageAddContact = BehaviorSubject<String>();
  Function(String) get updateMessageAddContact => _messageAddContact.sink.add;

  Future _showSnackbar(BuildContext context, String message) {
    if (context != null) {
      AppMessage appMessage = AppMessage(message);
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(appMessage.snackBar);
    }
    return null;
  }

  void displaySnackbar(BuildContext context, String message) {
    _showSnackbar(context, message);
  }

  void dispose() {
    _messageHome.close();
    _messageAddContact.close();
  }
}
