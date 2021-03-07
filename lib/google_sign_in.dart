import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


//All steps for Google Sign In with Firebase at one place as a Function
Future<User> googleSignIn() async{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=GoogleSignIn();
  
  GoogleSignInAccount googleSignInAccount= await googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;
  
  GoogleAuthCredential credential=GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken
  );

  UserCredential authResult=await _auth.signInWithCredential(credential);
  User user=authResult.user;
  return user;

}