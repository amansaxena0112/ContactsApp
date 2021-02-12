import 'package:contacts_app/src/blocs/detail_bloc.dart';
import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/providers/detail_bloc_provider.dart';
import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailBlocProvider(
      child: AddContactScreenBase(),
    );
  }
}

class AddContactScreenBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
    DetailBloc detailBloc = DetailBlocProvider.getDetailBloc(context);
    ContactModel selectedContactModel = detailBloc.contactModelValue;
    return StreamBuilder(
        stream: detailBloc.contactModel,
        builder: (BuildContext context, AsyncSnapshot<ContactModel> snapshot) {
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
                          Container(
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                color: Colors.cyan,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Image.asset('assets/placeholder_photo.png')),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 110,
                              left: 100,
                            ),
                            child: Image.asset(
                              'assets/camera_button.png',
                              width: 40,
                              height: 40,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              // controller: ,
                              onChanged: (value) {},
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              // controller: ,
                              onChanged: (value) {},
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              // controller: ,
                              onChanged: (value) {},
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              // controller: ,
                              onChanged: (value) {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 10,
                  //       bottom: 10,
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           width: 100,
                  //           child: Text(
                  //             'First Name',
                  //             textAlign: TextAlign.right,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.symmetric(horizontal: 20.0),
                  //           child: TextField(
                  //             // controller: ,
                  //             onChanged: (value) {},
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 10,
                  //       bottom: 10,
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           width: 100,
                  //           child: Text(
                  //             'Last Name',
                  //             textAlign: TextAlign.right,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.symmetric(horizontal: 20.0),
                  //           child: TextField(
                  //             // controller: ,
                  //             onChanged: (value) {},
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          );
        });
  }
}
