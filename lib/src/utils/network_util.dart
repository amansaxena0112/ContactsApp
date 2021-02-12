import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_app/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // CommonUtil _commonUtil = CommonUtil();
  bool isProduction = bool.fromEnvironment('dart.vm.product');

  Uri getUri(String path, {Map<String, dynamic> queryParams: const {}}) {
    // if (isProduction) {
    //   return Uri(
    //     host: Constants.HOST_PROD,
    //     path: path,
    //     scheme: Constants.PROTOCOL_PROD,
    //     queryParameters: queryParams,
    //   );
    // } else {
    //   return Uri(
    //     host: Constants.hostDev,
    //     path: path,
    //     port: Constants.PORT,
    //     scheme: Constants.PROTOCOL_DEV,
    //     queryParameters: queryParams,
    //   );
    // }
    return Uri(
      host: Constants.HOST_PROD,
      path: path,
      port: Constants.PORT,
      scheme: Constants.PROTOCOL_PROD,
      queryParameters: queryParams,
    );
  }

  Future<http.Response> getContacts() {
    print(getUri(Constants.CONTACTS));
    // print(_commonUtil.user.accessToken);
    return http.get(
      getUri(Constants.CONTACTS),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Authorization': 'Bearer ${_commonUtil.user.accessToken}',
      // },
    );
  }
}
