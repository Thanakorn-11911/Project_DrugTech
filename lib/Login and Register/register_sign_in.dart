import 'package:flutter/material.dart';

import 'register_sign_up.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Login to your account',
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
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2962FF),
                  ),
                  child: const Text('Sign in'),
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
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Don't have an account?",
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 12,
                      color: const Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterSignUpScreen();
                      }));
                    },
                    child: const Text('Sign up'),
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
