import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/Model/drug.dart';
import 'package:ddd/Model/user.dart';
import 'package:ddd/screens/Admin/detail.dart';
import 'package:ddd/screens/Admin/menu.dart';
import 'package:ddd/screens/Admin/search.dart';
import 'package:ddd/services/auth.dart';
import 'package:ddd/services/constants.dart';
import 'package:ddd/services/db.dart';
import 'package:ddd/shared/getImage.dart';
import 'package:ddd/shared/getImageTFlite.dart';
import 'package:ddd/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeUserPage extends StatefulWidget {
  //const HomeUserPage({ Key? key }) : super(key: key);

  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  AuthService auth = AuthService();
  UsersM _usersM;
  final key = GlobalKey<ScaffoldState>();
  final CollectionReference drugscol =
      FirebaseFirestore.instance.collection("drugs");
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Drug Tech'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: drugscol.snapshots(),
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
                                SizedBox(
                                    width: double.infinity,
                                    child: data.images.isNotEmpty
                                        ? Ink.image(
                                            height: 200,
                                            image: NetworkImage(
                                                "${data.images[0]}"),
                                            fit: BoxFit.fitWidth,
                                          )
                                        : null),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'GenericName : ${data.genericName}',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        'Status : ${data.statusId}',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      )
                                    ],
                                  )
                                ],
                              ),
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
          color: gradientStartColor,
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => TFLITEPage()));
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
          ],
        ),
      ),
    );
  }
}
