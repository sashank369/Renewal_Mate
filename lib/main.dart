import 'package:flutter/material.dart';
import 'Welcome_page.dart';
import 'SignUpPage.dart';
import 'SignInPage.dart';
import 'HomePage.dart';
import 'AddDeadline.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(), 
      debugShowCheckedModeBanner: false,
    );
  }
}
