import 'package:contacts_app/src/blocs/detail_bloc.dart';
import 'package:contacts_app/src/blocs/home_bloc.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/providers/home_bloc_provider.dart';
import 'package:contacts_app/src/utils/navigator_util.dart';
import 'package:contacts_app/src/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
            onPressed: () {
              NavigatorUtil().navigateToScreen(context, '/add-contact');
            },
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
    SnackbarUtil _snackbarUtil = SnackbarUtil();
    _snackbarUtil.buildContextHome = context;
    return Stack(
      fit: StackFit.expand,
      children: [
        StreamBuilder(
            stream: homeBloc.contactModelList,
            builder: (BuildContext context,
                AsyncSnapshot<List<ContactModel>> snapshot) {
              if (snapshot.hasData && snapshot.data.length > 0) {
                print('!!!!!!!!!!!!!!!');
                print(snapshot.data.length);
                return ScrollablePositionedList.builder(
                  itemScrollController: homeBloc.itemScrollController,
                  itemPositionsListener: homeBloc.itemPositionsListener,
                  itemCount: snapshot.data.length,
                  // maxItemCount: snapshot.data.length - 1,
                  // addAutomaticKeepAlives: false,
                  // addRepaintBoundaries: false,
                  // emptyItemBuilder: (context, index) {
                  //   return Container();
                  // },
                  // minItemCount: 0,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    return GestureDetector(
                      onTap: () {
                        DetailBloc().updateContactModel(snapshot.data[index]);
                        DetailBloc().updateIndex(index);
                        NavigatorUtil().navigateToScreen(context, '/detail');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Card(
                              key: ValueKey(index),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                        color: Colors.cyan,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${snapshot.data[index].firstName.substring(0, 1)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                          '${snapshot.data[index].firstName} ${snapshot.data[index].lastName}'),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    snapshot.data[index].favorite
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.cyan,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
            width: 30,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 0, top: 70),
            child: ListView.builder(
              itemCount: homeBloc.alphabet.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    homeBloc.filterList(homeBloc.alphabet[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      homeBloc.alphabet[index],
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
