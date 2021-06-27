import 'dart:math';

import 'package:ddd/services/auth.dart';
import 'package:ddd/services/constants.dart';
import 'package:ddd/shared/loading.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  //RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService auth = AuthService();
  String email, pass, username, cpass;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: navigationColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Container(
                  width: 200.0,
                  height: 150.0,
                  child: Image.asset("images/01.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'Create your Account',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 16,
                        color: const Color(0xFF616161),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (e) => username = e,
                  validator: (e) => e.isEmpty ? "not null" : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (e) => email = e,
                  validator: (e) => e.isEmpty ? "not null" : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  onChanged: (e) => pass = e,
                  validator: (e) => e.isEmpty
                      ? "not null"
                      : e.length < 6
                          ? "password don"
                          : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: "***************",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  onChanged: (e) => cpass = e,
                  validator: (e) => e.isEmpty
                      ? "not null"
                      : e.length < 6
                          ? "password don"
                          : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: "***************",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: navigationColor,
                    ),
                    onPressed: () async {
                      if (formkey.currentState.validate()) {
                        loading(context);
                        bool register =
                            await auth.signup(email, pass, username);
                        if (register != null) {
                          Navigator.of(context).pop();
                          if (register) Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text('Sign up'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '- Or sign in with -',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 12,
                        color: const Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
