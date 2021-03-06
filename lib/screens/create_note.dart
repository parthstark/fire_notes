import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Note extends StatefulWidget {
  final uid;
  Note(this.uid);
  @override
  _NoteState createState() => _NoteState(uid);
}

class _NoteState extends State<Note> {
  String uid;
  var _title=TextEditingController();
  var _content=TextEditingController();
  var myNotes;
  
  
  _NoteState(uid){
    this.uid=uid;
    this.myNotes=FirebaseFirestore.instance.collection('users').doc(uid).collection('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          FloatingActionButton(
            heroTag: "del",
            onPressed:(){Navigator.pop(context);},
            child:Icon(Icons.delete)
          ),
          FloatingActionButton(
            heroTag: "snd",
            onPressed:(){
              myNotes.add({
                'title':_title.text,
                'content':_content.text
              });
              Navigator.pop(context);
            },
            child:Icon(Icons.send)
          ),
        ]
      ),
      


      body: Container(
        child:Card(
          margin: EdgeInsets.all(16),

          child: SingleChildScrollView(
              child: Column(
              children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color:Colors.blue)),
                  border: InputBorder.none,
                ),
              ),

              Divider(),
              
              TextField(
              controller: _content,
              maxLines: 50,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,900),
                  child: Icon(Icons.content_paste),
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color:Colors.blue)),
                border: InputBorder.none,
              ),
              ),
            ],),
          )
        )
      ),
    );
  }
}


