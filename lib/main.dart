import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //To initialise app with FireBase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //Firebase Authentication Instance Created
  final FirebaseAuth _auth=FirebaseAuth.instance;

  //Firebase user created
  User user;

  MyApp(){

    //Current logged in user is put inside Firebase user
    user=_auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fire Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //If user is logged in goto Home screen else Login Screen
      home: user==null
        ?Login()
        :Home(user.uid)
    );
  }
}

