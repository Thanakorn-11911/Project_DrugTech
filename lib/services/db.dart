import 'dart:io';
import 'package:ddd/Model/drug.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/Model/user.dart';

class dbService {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference drugscol =
      FirebaseFirestore.instance.collection("drugs");

  Future saveUser(UsersM user) async {
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser(String id) async {
    try {
      final data = await usercol.doc(id).get();
      final user = UsersM.fromJson(data.data());
      return user;
    } catch (e) {
      return false;
    }
  }

  Future updateUser(UsersM user) async {
    try {
      await usercol.doc(user.id).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<UsersM> get getCurrentUser {
    final user = FirebaseAuth.instance.currentUser;
    return user != null
        ? usercol
            .doc(user.uid)
            .snapshots()
            .map((user) => UsersM.fromJson(user.data()))
        : null;
  }

  Future loadFile(File file, {String path}) async {
    var time = DateTime.now().toString();
    //var ext = Path.basename(file.path).split(".")[1].toString();
    String image = file.path.split('/').last;
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(path + "/" + image);
      firebase_storage.UploadTask upload = ref.putFile(file);
      return upload.whenComplete(() {}).then((_) async {
        return await ref.getDownloadURL();
      });
    } catch (e) {}
  }

  Future saveDrugs(Drugs drugs) async {
    try {
      await drugscol.doc().set(drugs.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Stream<List<UsersM>> get getDrug {
  //   return drugscol.snapshots().map((drugs) {
  //     return drugs.docs
  //         .map((e) => UsersM.fromJson(e.data(), id: e.id))
  //         .toList();
  //   });
  // }

  Future deleteDrugs(String id) async {
    try {
      await drugscol.doc(id).delete();
      print(id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future updateDrugs(Drugs drug, String id) async {
    try {
      await drugscol.doc(id).update(drug.toMap());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
