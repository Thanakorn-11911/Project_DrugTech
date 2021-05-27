import 'package:ddd/Login%20and%20Register/register_sign_in.dart';
import 'package:flutter/material.dart';

class RegisterSignUpScreen extends StatefulWidget {
  @override
  _RegisterSignUpScreenState createState() => _RegisterSignUpScreenState();
}

class _RegisterSignUpScreenState extends State<RegisterSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2962FF),
                  ),
                  onPressed: () {},
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
    );
  }
}
