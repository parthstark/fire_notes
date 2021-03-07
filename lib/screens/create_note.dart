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
  var _title = TextEditingController();
  var _content = TextEditingController();
  var myNotes;

  int _groupValue = 0;

  _NoteState(uid) {
    this.uid = uid;

    //myNotes has a COLLECTION reference of 'notes' inside UserID(uid) DOCUMENT inside COLLECTION of all 'users'
    this.myNotes = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        elevation: 0,
        title: Text(
          "Create your FireNote",
          textScaleFactor: 1.25,
        ),
      ),

      //To Create 2 Floating action buttons
      //floatingActionButton has Row in which there are 2 FloatingActionButton
      //Each has a unique heroTag so that on opening this page there is no error
      //The buttons are evenlySpaced in a row
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FloatingActionButton(
          heroTag: "del",
          child: Icon(Icons.delete),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FloatingActionButton(
          heroTag: "snd",
          child: Icon(Icons.send),
          onPressed: () {
            //This Map is added in the notes collection of the current loggedIn User
            myNotes.add({
              'title': _title.text,
              'content': _content.text,
              'priority': _groupValue
            });
            Navigator.pop(context);
          },
        ),
      ]),

      body: Container(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Title Input Field
                    TextField(
                      style: TextStyle(color: Colors.grey[800]),
                      controller: _title,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue)),
                        border: InputBorder.none,
                      ),
                    ),

                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      //Radio Buttons in a Row
                      child: Row(children: [
                        Text("Select Note Priority",
                            style: TextStyle(color: Colors.grey[500])),
                        Expanded(child: SizedBox()),

                        //Radio Buttons of one group share a common groupValue with same dataType as value
                        //On selecting one Radio newValue is assigned to groupValue variable
                        //and setState is called to display the change on screen
                        Radio(
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (newValue) =>
                              setState(() => _groupValue = newValue),
                        ),
                        Text("Low", style: TextStyle(color: Colors.grey[500])),
                        SizedBox(
                          width: 20,
                        ),

                        Radio(
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (newValue) =>
                              setState(() => _groupValue = newValue),
                        ),
                        Text("High", style: TextStyle(color: Colors.grey[500])),
                      ]),
                    ),
                    Divider(),

                    TextField(
                      style: TextStyle(color: Colors.grey[800]),
                      controller: _content,
                      maxLines: 50,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 900),
                          child: Icon(Icons.content_paste),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue)),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
