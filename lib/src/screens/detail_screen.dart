import 'package:contacts_app/src/blocs/detail_bloc.dart';
import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/providers/detail_bloc_provider.dart';
import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DetailBlocProvider(
      child: DetailScreenBase(),
    );
  }
}

class DetailScreenBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Contact',
          style: TextStyle(
            color: Colors.tealAccent,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(
                color: Colors.tealAccent,
              ),
            ),
          ),
        ],
      ),
      body: DetailScreenBody(),
    );
  }
}

class DetailScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailBloc detailBloc = DetailBlocProvider.getDetailBloc(context);
    ContactModel selectedContactModel = detailBloc.contactModelValue;
    return StreamBuilder(
        stream: detailBloc.contactModel,
        builder: (BuildContext context, AsyncSnapshot<ContactModel> snapshot) {
          return Column(
            children: [
              Flexible(
                child: Container(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${selectedContactModel.firstName.substring(0, 1)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          '${selectedContactModel.firstName} ${selectedContactModel.lastName}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            createButtons(
                                'assets/message_button.png', 'message'),
                            createButtons('assets/call_button.png', 'call'),
                            createButtons('assets/email_button.png', 'email'),
                            snapshot.hasData && snapshot.data.favorite
                                ? GestureDetector(
                                    onTap: () {
                                      selectedContactModel.favorite = false;
                                      detailBloc.updateContactModel(
                                          selectedContactModel);
                                    },
                                    child: createButtons(
                                        'assets/favourite_button_selected.png',
                                        'favourite'),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      selectedContactModel.favorite = true;
                                      detailBloc.updateContactModel(
                                          selectedContactModel);
                                    },
                                    child: createButtons(
                                        'assets/favourite_button.png',
                                        'favourite'),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                child: Text(
                                  'mobile',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  snapshot.hasData &&
                                          snapshot.data.phone != null
                                      ? '+91 ${snapshot.data.phone}'
                                      : '',
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'email',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  snapshot.hasData &&
                                          snapshot.data.email != null
                                      ? snapshot.data.email
                                      : '',
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget createButtons(String asset, String title) {
    return Column(
      children: [
        Image.asset(
          asset,
          width: 40,
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(title),
        )
      ],
    );
  }
}
