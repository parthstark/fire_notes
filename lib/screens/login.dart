import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../google_sign_in.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final formKey=GlobalKey<FormState>();
  // final _emailController=TextEditingController();
  // final _pwdController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        // key: formKey,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            // TextFormField(
            //   controller: _emailController,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     helperText: "email",
            //   ),
            // ),
            // TextFormField(
            //   controller: _pwdController,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     helperText: "password",
            //   ),
            // ),
            // InkWell(
            //   onTap: (){},
            //   child: Container(
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.blue[300],
            //     ),
            //     height: 50,
            //     width: 250,
            //     child: Text("Logout",style: TextStyle(color: Colors.white),),
            //   ),
            // ),


            InkWell(
              onTap: () async{
                User user= await googleSignIn();
                if(user!=null){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                }
              },
              child: Container(
                height: 120,
                child: Card(
                  shape: StadiumBorder(),
                  color:Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    Text("G",textScaleFactor: 6,),
                    SizedBox(width:30),
                    Text("Login",textScaleFactor: 3,)
                  ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}