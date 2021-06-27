import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/HomeScreen/startandreg.dart';
import 'services/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drug Tech',
      theme: ThemeData(
        primaryColor: navigationColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      //home: LoginPage(),
      //home: StatusAuth(),
      debugShowCheckedModeBanner: false,
    );
  }
}
