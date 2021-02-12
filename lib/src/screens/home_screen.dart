import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomeScreenDetail();
  }
}

class _HomeScreenDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contact',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.cyanAccent,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = HomeBlocProvider.getHomeBloc(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Container(
        //   color: Colors.amber,
        // ),
        StreamBuilder(
            stream: homeBloc.contactModelList,
            builder: (BuildContext context,
                AsyncSnapshot<List<ContactModel>> snapshot) {
              if (snapshot.hasData && snapshot.data.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 70,
                            child: Text('${snapshot.data[index].firstName}'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 20,
            padding: const EdgeInsets.only(left: 5, top: 70),
            child: ListView.builder(
              itemCount: homeBloc.alphabet.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(homeBloc.alphabet[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
