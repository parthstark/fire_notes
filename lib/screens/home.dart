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

  //FirebaseAuth and GoogleSignIn instances are created for logout functionality
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn=GoogleSignIn();

  var myNotes;

  _HomeState(id){
    this.id=id;

    //myNotes has a COLLECTION reference of 'notes' inside UserID(uid) DOCUMENT inside COLLECTION of all 'users'
    myNotes=FirebaseFirestore.instance.collection('users').doc(id).collection('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft :Radius.circular(30), bottomRight:Radius.circular(30))),
        elevation: 0,
        title: Text("Welcome to FireNotes",textScaleFactor: 1.25,),

        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            //Onpressing Action button, LogOut of FireBase and Google
            await _auth.signOut();
            await _googleSignIn.signOut();
            //Then push to Login Page
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

      //Firestore sends streams of data -> so StreamBuilder is used
      body: Stack(
        children: [
          Positioned(
            child: Image.asset("assets/img2.png",height: 300,),
            bottom: 0,
            right: 0,  
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: StreamBuilder(

              //snapshots are captured from myNotes(contain all documents of individual notes)
              stream: myNotes.snapshots(),


              //context and snapshot is passed in stream builder -> to create a list of snapshots
              //mentioning datatype of snapshot "AsyncSnapshot<QuerySnapshot>" makes it better
              //QuerySnapshot for doc and DocumentSnapshot for collection
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                return ListView.builder(

                  //if list of snapshot has length then snapshot.data.length else 0
                  itemCount: snapshot.hasData?snapshot.data.docs.length:0,

                  itemBuilder: (BuildContext context, int index) {

                  return InkWell(

                    //Open page to edit note on tapping any note and the DOCUMENT SNAPSHOT of current INDEX is PASSED
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(snapshot.data.docs[index])));
                    },
                    
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(horizontal:10, vertical:5),
                        child: ListTile(
                        leading: snapshot.data.docs[index].data()['priority']==0
                                  ?Icon(Icons.keyboard_arrow_right,color: Colors.blue,)
                                  :Icon(Icons.notification_important,color: Colors.red,),
                        title: Text(snapshot.data.docs[index].data()['title'],textScaleFactor: 1.5,maxLines: 2,overflow: TextOverflow.ellipsis,),
                        subtitle: Text(snapshot.data.docs[index].data()['content'],maxLines: 10,overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                  );
                 },
                );
              }
            ),
          ),
        ],
      ),

      
    );
  }
}