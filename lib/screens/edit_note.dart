import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNote extends StatefulWidget {
  final snapshot;
  EditNote(this.snapshot);
  @override
  _EditNoteState createState() => _EditNoteState(snapshot);
}

class _EditNoteState extends State<EditNote> {
  TextEditingController _title;
  TextEditingController _content;
  QueryDocumentSnapshot snapshot;
  _EditNoteState(snapshot){
    this.snapshot=snapshot;
    _title=TextEditingController(text:snapshot.data()['title']);
    _content=TextEditingController(text:snapshot.data()['content']);
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
            onPressed:(){
              snapshot.reference.delete();
              Navigator.pop(context);
            },
            child:Icon(Icons.delete)
          ),
          FloatingActionButton(
            heroTag: "snd",
            onPressed:(){
              snapshot.reference.set({
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


