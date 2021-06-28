import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/Model/drug.dart';
import 'package:ddd/Model/user.dart';
import 'package:ddd/screens/Admin/addDrug.dart';
import 'package:ddd/screens/Admin/detail.dart';
import 'package:ddd/screens/Admin/menu.dart';
import 'package:ddd/screens/Admin/search.dart';
import 'package:ddd/screens/Admin/update.dart';
import 'package:ddd/services/auth.dart';
import 'package:ddd/services/constants.dart';
import 'package:ddd/services/db.dart';
import 'package:ddd/shared/getImage.dart';
import 'package:ddd/shared/getImageTFlite.dart';
import 'package:ddd/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stream_provider/stream_provider.dart';

class HomeAdminPage extends StatefulWidget {
  //HomeAdminPage({Key? key}) : super(key: key);

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  AuthService auth = AuthService();
  UsersM _usersM;
  final key = GlobalKey<ScaffoldState>();
  final CollectionReference drugscol =
      FirebaseFirestore.instance.collection("drugs");
  final ScrollController controller = ScrollController();
  Future<void> getUser() async {
    User user = await auth.user;
    final userResult = await dbService().getUser(user.uid);

    _usersM = userResult;
    UsersM.current = userResult;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            key: key,
            drawer: Menu(),
            appBar: AppBar(
              title: Text('Home page'),
              actions: [
                InkWell(
                  onTap: () {
                    key.currentState.openDrawer();
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        backgroundImage: _usersM.image != null
                            ? NetworkImage(_usersM.image)
                            : null,
                        child: _usersM.image != null
                            ? Container()
                            : Icon(
                                Icons.person,
                                color: navigationColor,
                              ),
                      ),
                      Text(_usersM.username),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(FontAwesomeIcons.powerOff),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text('disconnect'),
                              content: Text('disconnect'),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await auth.sigOut();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                )
                              ],
                            );
                          });
                    }),
              ],
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: drugscol.snapshots(),
              //  FirebaseFirestore.instance
              //     .collection("drugInformation")
              //     .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    controller: controller,
                    children: snapshot.data.docs.map((document) {
                      final data = Drugs.fromJson(document.data());
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: cardColor,
                            clipBehavior: Clip.antiAlias,
                            elevation: 16,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => Detail(test: data)));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      if (data.images.isNotEmpty)
                                        Ink.image(
                                          height: 200,
                                          image: NetworkImage(
                                              "${data.images.first}"),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          data.brandName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 16,
                                      right: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'GenericName : ${data.genericName}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              'Status : ${data.statusId}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  ButtonBar(
                                    children: <Widget>[
                                      //delete
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    child: Container(
                                                      width: 200,
                                                      height: 100,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            child: Text(
                                                                'Do you want to delete this data?'),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Colors
                                                                      .green
                                                                      .shade900,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  loading(
                                                                      context);
                                                                  dbService()
                                                                      .deleteDrugs(
                                                                          document
                                                                              .id);
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      context);

                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              OutlinedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green
                                                                          .shade900),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Color(0xFF1B5E20)),
                                        ),
                                      ),
                                      //Update
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (ctx) => UpdatePage(
                                                        data: data,
                                                        id: document.id,
                                                      )));
                                        },
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Color(0xFF1B5E20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(36.0),
                ),
                color: navigationColor,
              ),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        controller.animateTo(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => TFLITEPage()));
                      },
                      tooltip: 'Pick Image'),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        showSearch(
                            context: context, delegate: CustomSearchDelegate());
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => AddDrug()));
                      })
                ],
              ),
            ),
          );
        });
  }
}
