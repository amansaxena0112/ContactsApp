import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/utils/connectivity_util.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:contacts_app/src/utils/network_util.dart';
import 'package:contacts_app/src/utils/permission_util.dart';
import 'package:contacts_app/src/utils/snackbar_util.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_permissions_helper/permissions_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddContactBloc extends Object {
  static final AddContactBloc _addContactBloc = AddContactBloc._();
  factory AddContactBloc() => _addContactBloc;
  AddContactBloc._() {
    _networkUtil = NetworkUtil();
    _connectivityUtil = ConnectivityUtil();
    _snackbarUtil = SnackbarUtil();
    _navigatorUtil = NavigatorUtil();
    _permissionsUtil = PermissionsUtil();
  }

  String imagePath;
  NetworkUtil _networkUtil;
  NavigatorUtil _navigatorUtil;
  ConnectivityUtil _connectivityUtil;
  PermissionsUtil _permissionsUtil;
  SnackbarUtil _snackbarUtil;
  List<ContactModel> contactModels = [];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  BehaviorSubject<ContactModel> _contactModel = BehaviorSubject<ContactModel>();
  BehaviorSubject<String> _firstName = BehaviorSubject<String>();
  BehaviorSubject<String> _lastName = BehaviorSubject<String>();
  BehaviorSubject<String> _mobile = BehaviorSubject<String>();
  BehaviorSubject<String> _email = BehaviorSubject<String>();
  BehaviorSubject<File> _image = BehaviorSubject<File>();

  Stream<ContactModel> get contact => _contactModel.stream;
  ContactModel get contactValue => _contactModel.stream.value;
  Function(ContactModel) get updateContact => _contactModel.sink.add;
  Stream<String> get firstName => _firstName.stream;
  String get firstNameValue => _firstName.stream.value;
  Function(String) get updateFirstName => _firstName.sink.add;
  Stream<String> get lastName => _lastName.stream;
  String get lastNameValue => _lastName.stream.value;
  Function(String) get updateLastName => _lastName.sink.add;
  Stream<String> get mobile => _mobile.stream;
  String get mobileValue => _mobile.stream.value;
  Function(String) get updateMobile => _mobile.sink.add;
  Stream<String> get email => _email.stream;
  String get emailValue => _email.stream.value;
  Function(String) get updateEmail => _email.sink.add;
  Stream<File> get image => _image.stream;
  File get imageValue => _image.stream.value;
  Function(File) get updateImage => _image.sink.add;

  void dispose() {
    _contactModel.close();
    _lastName.close();
    _firstName.close();
    _mobile.close();
    _email.close();
    _image.close();
  }

  Future<bool> clearAll() async {
    return true;
  }

  Future<bool> validateContact() async {
    ContactModel contactModel;
    if ((firstNameValue == null || firstNameValue.isEmpty) ||
        (lastNameValue == null || lastNameValue.isEmpty) ||
        (mobileValue == null || mobileValue.isEmpty) ||
        (emailValue == null || emailValue.isEmpty)) {
      _snackbarUtil.updateMessageAddContact('Enter all contact details');
      return false;
    }
    contactModel = ContactModel.fromMap({
      'firstname': firstNameValue,
      'lastname': lastNameValue,
      'email': emailValue,
      'phone': mobileValue,
      'favourite': true,
    });
    updateContact(contactModel);
    return true;
  }

  Future<void> choosefromDialog(BuildContext context, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose document'),
          content: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text('Gallery'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    updateImageFile(context, ImageSource.gallery, title);
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text('Camera'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    updateImageFile(context, ImageSource.camera, title);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future updateImageFile(
      BuildContext context, ImageSource source, String title) async {
    NavigatorUtil navigatorUtil = NavigatorUtil();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    }
    PermissionStatus permissionStatus;
    bool isEnabled = true;
    if (Platform.isIOS ||
        (Platform.isAndroid && androidInfo.version.sdkInt >= 23)) {
      PermissionsUtil permissionUtil = PermissionsUtil();
      permissionStatus =
          await permissionUtil.requestPermission(source == ImageSource.gallery
              ? Platform.isIOS
                  ? Permission.PhotoLibrary
                  : Permission.ReadExternalStorage
              : Permission.Camera);
      isEnabled = permissionStatus == PermissionStatus.Granted ? true : false;
    }
    if (isEnabled) {
      navigatorUtil.pop(context);
      File file = await ImagePicker.pickImage(source: source);
      double fileSize = file.lengthSync() / (1024 * 1024);
      if (file != null) {
        if (fileSize > 1.5) {
          getTemporaryDirectory().then((dir) async {
            String targetPath =
                '${dir.path}/${title.replaceAll('/', '_')}_${DateTime.now().toString()}.jpg';
            compressAndGetFile({
              'file': file,
              'targetPath': targetPath,
            }).then((compressedImage) {
              updateImageDetails(compressedImage, targetPath);
            });
          });
        } else {
          updateImageDetails(file, file.absolute.path);
        }
      }
    } else if (Platform.isIOS ||
        (Platform.isAndroid &&
            permissionStatus == PermissionStatus.DeniedAndDisabled)) {
      navigatorUtil.pop(context);
      String sourceType = source == ImageSource.camera
          ? 'Camera'
          : Platform.isIOS
              ? 'Photos'
              : 'Storage';
      openSettings(context, '$sourceType permission is disabled.');
    }
  }

  Future<File> compressAndGetFile(Map<String, dynamic> params) async {
    double fileSize = params['file'].lengthSync() / (1024 * 1024);
    int quality;
    if (fileSize < 3.0) {
      quality = 75;
    } else if (fileSize < 4.0) {
      quality = 50;
    } else {
      quality = 25;
    }
    var result = await FlutterImageCompress.compressAndGetFile(
      params['file'].absolute.path,
      params['targetPath'],
      quality: quality,
    );
    return result;
  }

  void updateImageDetails(File file, String path) {
    //image = file;
    updateImage(file);
    imagePath = path;
  }

  Future<bool> openSettings(BuildContext context, String message) {
    NavigatorUtil _navigatorUtil = NavigatorUtil();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Permission Alert'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => _navigatorUtil.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                _permissionsUtil.openSettings();
                _navigatorUtil.pop(context);
              },
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // color: Colors.lightBlue[300],
            ),
          ],
        );
      },
    );
  }

  void resetData() {
    updateFirstName(null);
    updateLastName(null);
    updateMobile(null);
    updateEmail(null);
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    emailController.clear();
  }

  Future<bool> saveContact(BuildContext context) async {
    if (_connectivityUtil.isConnectionActive) {
      try {
        _navigatorUtil.showLoader(context, 'Please wait');
        http.Response response = await _networkUtil.saveContact(contactValue);
        _navigatorUtil.hideLoader(context, false);
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 500) {
          _snackbarUtil.updateMessageAddContact('Something went wrong!');
          return false;
        } else if (response.statusCode == 201) {
          resetData();
          await HomeBloc().getContacts(context);
          _navigatorUtil.pop(context);
          _snackbarUtil.updateMessageHome('Contact added successfully.');
          return true;
        } else {
          _snackbarUtil.updateMessageAddContact(response.body);
          return false;
        }
      } catch (ex, t) {
        print(ex);
        print(t);
        return false;
      }
    } else {
      _snackbarUtil.updateMessageAddContact(
          'No network available. Check your connection');
      return false;
    }
  }
}
