import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/Model/drug.dart';
import 'package:ddd/screens/Admin/detail.dart';

import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final CollectionReference drugscol =
      FirebaseFirestore.instance.collection("drugs");
  final StreamController<String> search = StreamController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    search.add(query);
    return StreamBuilder<QuerySnapshot>(
        stream: drugscol.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<String>(
                stream: search.stream,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView(
                        children: snapshot.data.docs
                            .map((e) => Drugs.fromJson(e.data()))
                            .where((e) =>
                                e.brandName?.trim()?.toLowerCase()?.startsWith(
                                    snap.data.trim().toLowerCase()) ??
                                false)
                            .map((data) {
                      return Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => Detail(test: data)));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: data.images.isNotEmpty
                                    ? NetworkImage("${data.images[0]}")
                                    : null),
                            title: Text(data.brandName),
                            subtitle: Text("${data.genericName}"
                                "status : ${data.statusId}"),
                          ),
                        ),
                      );
                    }).toList());
                  }

                  return ListView(
                      children: snapshot.data.docs
                          .map((e) => Drugs.fromJson(e.data()))
                          .map((data) {
                    return Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => Detail(test: data)));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: data.images.isNotEmpty
                                  ? NetworkImage("${data.images[0]}")
                                  : null),
                          title: Text(data.brandName),
                          subtitle: Text("${data.genericName}"
                              "status : ${data.statusId}"),
                        ),
                      ),
                    );
                  }).toList());
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    search.add(query);
    return StreamBuilder<QuerySnapshot>(
        stream: drugscol.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<String>(
                stream: search.stream,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView(
                        children: snapshot.data.docs
                            .map((e) => Drugs.fromJson(e.data()))
                            .where((e) =>
                                e.brandName?.trim()?.toLowerCase()?.startsWith(
                                    snap.data.trim().toLowerCase()) ??
                                false)
                            .map((data) {
                      return Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => Detail(test: data)));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: data.images.isNotEmpty
                                    ? NetworkImage("${data.images[0]}")
                                    : null),
                            title: Text(data.brandName),
                            subtitle: Text("${data.genericName}"
                                "status : ${data.statusId}"),
                          ),
                        ),
                      );
                    }).toList());
                  }

                  return ListView(
                      children: snapshot.data.docs
                          .map((e) => Drugs.fromJson(e.data()))
                          .map((data) {
                    return Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => Detail(test: data)));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: data.images.isNotEmpty
                                  ? NetworkImage("${data.images[0]}")
                                  : null),
                          title: Text(data.brandName),
                          subtitle: Text("${data.genericName}"
                              "status : ${data.statusId}"),
                        ),
                      ),
                    );
                  }).toList());
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
