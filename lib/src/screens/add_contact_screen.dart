import 'dart:io';

import 'package:contacts_app/src/blocs/add_contact_bloc.dart';
import 'package:contacts_app/src/blocs/detail_bloc.dart';
import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/providers/add_contact_bloc_provider.dart';
import 'package:contacts_app/src/providers/detail_bloc_provider.dart';
import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:contacts_app/src/utils/snackbar_util.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddContactBlocProvider(
      child: AddContactScreenBase(),
    );
  }
}

class AddContactScreenBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddContactBloc addContactBloc =
        AddContactBlocProvider.getAddContacBloc(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: TextButton(
          onPressed: () {
            NavigatorUtil().pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.tealAccent,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              bool isValid = await addContactBloc.validateContact();
              if (isValid) {
                addContactBloc.saveContact(context);
              }
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.tealAccent,
              ),
            ),
          ),
        ],
      ),
      body: AddContactScreenBody(),
    );
  }
}

class AddContactScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddContactBloc addContactBloc =
        AddContactBlocProvider.getAddContacBloc(context);
    SnackbarUtil _snackbarUtil = SnackbarUtil();
    _snackbarUtil.buildContextAddContact = context;
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.white,
                Colors.teal[100],
              ],
              stops: [0.0, 0.3],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    StreamBuilder(
                        stream: addContactBloc.image,
                        builder: (BuildContext context,
                            AsyncSnapshot<File> snapshot) {
                          return Container(
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                color: Colors.cyan,
                                shape: BoxShape.circle,
                              ),
                              child: snapshot.hasData
                                  ? CircleAvatar(
                                      radius: 70.0,
                                      backgroundColor:
                                          Color.fromRGBO(247, 249, 249, 1),
                                      child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(100.0),
                                        child: Image.file(
                                          snapshot.data,
                                          fit: BoxFit.fill,
                                          matchTextDirection: true,
                                          filterQuality: FilterQuality.low,
                                          height: 140,
                                          width: 140,
                                        ),
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/placeholder_photo.png'));
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 110,
                        left: 100,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          addContactBloc.choosefromDialog(context, 'profile');
                        },
                        child: Image.asset(
                          'assets/camera_button.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      'First Name',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: addContactBloc.firstNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          addContactBloc.updateFirstName(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      'Last Name',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: addContactBloc.lastNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          addContactBloc.updateLastName(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      'mobile',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, counterText: ''),
                        controller: addContactBloc.mobileController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        onChanged: (value) {
                          addContactBloc.updateMobile(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text(
                      'email',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: addContactBloc.emailController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          addContactBloc.updateEmail(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
