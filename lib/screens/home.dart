import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'edit_note.dart';
import 'login.dart';
import 'create_note.dart';

class Home extends StatefulWidget {
  final id;
  Home(this.id);
  @override
  _HomeState createState() => _HomeState(id);
}

class _HomeState extends State<Home> {
  String id;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn=GoogleSignIn();
  var myNotes;

  _HomeState(id){
    this.id=id;
    myNotes=FirebaseFirestore.instance.collection('users').doc(id).collection('notes');
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Note(id)));
        },
        child: Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: myNotes.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
            itemCount: snapshot.hasData?snapshot.data.docs.length:0,
            itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(snapshot.data.docs[index])));
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal:10, vertical:5),
                  child: ListTile(
                  title: Text(snapshot.data.docs[index].data()['title'],textScaleFactor: 1.5,maxLines: 2,overflow: TextOverflow.ellipsis,),
                  subtitle: Text(snapshot.data.docs[index].data()['content'],maxLines: 10,overflow: TextOverflow.ellipsis,),
                ),
              ),
            );
           },
          );
        }
      ),

      
    );
  }
}