import 'package:ddd/Login%20and%20Register/register_sign_in.dart';
import 'package:ddd/UserHomePage/home_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  },
                  icon: Icon(Icons.play_arrow_rounded),
                  label: Text("Start Application",
                      style: TextStyle(fontSize: 20)))),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    }));
                  },
                  icon: Icon(Icons.add_alarm_outlined),
                  label: Text("Addmin", style: TextStyle(fontSize: 20)))),
        ],
      ),
    );
  }
}
