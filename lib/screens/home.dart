import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn=GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to FireNotes"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            await _auth.signOut();
            await _googleSignIn.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
          })
        ],
      ),

      
    );
  }
}