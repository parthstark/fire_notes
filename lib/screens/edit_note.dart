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
  int _groupValue;
  
  //QuerySnapshot is received from home page
  QueryDocumentSnapshot snapshot;

  _EditNoteState(snapshot){
    this.snapshot=snapshot;

    //all Controllers are INITIALISED with SNAPSHOT'S DATA
    _title=TextEditingController(text:snapshot.data()['title']);
    _content=TextEditingController(text:snapshot.data()['content']);
    _groupValue=snapshot.data()['priority'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft :Radius.circular(30), bottomRight:Radius.circular(30))),
        elevation: 0,
        title: Text("Edit your FireNote",textScaleFactor: 1.25,),
      ),

      //floatingActionButton STARTS
      //MORE INFO about on floatingActionButton in create_note.dart
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
                'content':_content.text,
                'priority':_groupValue
              });
              Navigator.pop(context);
            },
            child:Icon(Icons.send)
          ),
        ]
      ),
      //floatingActionButton ENDS


      body: Container(
        child:Card(
          margin: EdgeInsets.all(16),

          child: SingleChildScrollView(
              child: Column(
              children: [
              TextField(
                style: TextStyle(color: Colors.grey[800]),
                controller: _title,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color:Colors.blue)),
                  border: InputBorder.none,
                ),
              ),


              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16),
  
                //Radio Buttons in a Row
                child: Row(
                  children:[
                  Text("Select Note Priority", style: TextStyle(color: Colors.grey[500])),
                  Expanded(child: SizedBox()),

                  //Radio Buttons of one group share a common groupValue with same dataType as value
                  //On selecting one Radio newValue is assigned to groupValue variable
                  //and setState is called to display the change on screen
                  Radio(
                    value:0,
                    groupValue: _groupValue,
                    onChanged: (newValue) => setState(() => _groupValue = newValue),
                  ),Text("Low", style: TextStyle(color: Colors.grey[500])),
                  SizedBox(width: 20,),

                  Radio(
                    value:1,
                    groupValue: _groupValue,
                    onChanged: (newValue) => setState(() => _groupValue = newValue),
                  ),Text("High", style: TextStyle(color: Colors.grey[500])),

                ]),
              ),
              Divider(),
              
              TextField(
                style: TextStyle(color: Colors.grey[800]),
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


