import 'package:firebase_app_web/pages/AddToDo.dart';
import 'package:firebase_app_web/pages/HomePage.dart';
import 'package:firebase_app_web/pages/SignInPage.dart';
import 'package:firebase_app_web/pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void signup() async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(
        email: "tgshirbhate@gmail.com", password: "123456"
      );
    }catch(e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: HomePage()
      );
  }
}