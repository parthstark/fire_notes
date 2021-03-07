import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../google_sign_in.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //FireStore 'user' Collections reference to check is user exists or not
  var reference=FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(24),

        child: 
        
          Column(
            children: [

              //UI elements begin

              SizedBox(height:50),
              Image.asset("assets/img1.png"),
              Text("FireNotes",textScaleFactor: 4,style: TextStyle(color: Colors.grey[800])),
              SizedBox(height: 10),
              Text("Keep all your notes synced at one place",textScaleFactor: 1.3, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[500])),
              SizedBox(height:150),
              InkWell(
                
                child: Container(
                  height: 120,
                  child: Card(
                    shape: StadiumBorder(),
                    color:Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                      Image.asset("assets/g.png",height: 60),
                      SizedBox(width:20),
                      Text("Login",textScaleFactor: 3,style: TextStyle(color: Colors.grey[800]))
                    ]),
                  ),
                ),

              //UI elements end
              
                            
              onTap: () async{
                User user= await googleSignIn();    //SignIn Function returns unique user

                //Snapshot of the document with Firebase User uid is returned
                var id= await reference.doc(user.uid).get();

                //if this Snapshot does not exists a new Document(Snapshot) is created in 'users' collection with an EMPTY MAP
                if(!id.exists){
                  reference.doc(user.uid).set({});
                }
                
                //Home screen receives user uid as string to - //TODO
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(user.uid)));
              },
            ),
          ],
        ),
      ),
    );
  }
}