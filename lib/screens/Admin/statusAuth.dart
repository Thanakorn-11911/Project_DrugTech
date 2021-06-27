import 'dart:ffi';

import 'package:ddd/screens/Admin/homeAdmin.dart';
import 'package:ddd/screens/Admin/login.dart';
import 'package:ddd/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusAuth extends StatefulWidget {
  //const StatusAuth({ Key? key }) : super(key: key);

  @override
  _StatusAuthState createState() => _StatusAuthState();
}

class _StatusAuthState extends State<StatusAuth> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: auth.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return !snapshot.hasData ? LoginPage() : HomeAdminPage();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
