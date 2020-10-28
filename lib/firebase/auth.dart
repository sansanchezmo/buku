import 'package:buku/firebase/firestore.dart';
import 'package:buku/initialization/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Import the firebase_core plugin

class Auth {
  FirebaseAuth _auth;
  String email;

  Auth() {
    this._auth = FirebaseAuth.instance;
  }

  Future<void> registerUser(String email, String password, String nickName,
      BuildContext context) async {
    email = email.trim();
    nickName = nickName.trim();
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {

        sendVerificationEmail();
        userCredential.user.updateProfile(displayName: nickName);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => LoginScreen(email: email,pass: password)
        ));

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showToast(context, 'The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }

  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    email = email.trim();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        if(userCredential.user.emailVerified){

          bool isNew = await Firestore().isNew(userCredential.user.uid);

          if(isNew){//TODO: isNewUser function doesn't serve at all.
            //TODO: create screen of UX guide
            Navigator.of(context).pushNamed('/newUser');

          }else{
            Navigator.of(context).pushNamed('/menu');
          }
        }else{

          String msg = 'An email has been sent to $email with a link to verify your Buku account.';
          _showDialog(context, msg, title: 'Email isn\'t verified');

        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showToast(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showToast(context, 'Wrong password provided for that user.');
      }
    }

  }

  void _showDialog(BuildContext context, String message, {String title = 'waning'}){

    showDialog(
        context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
      )
    );

  }

  void _showToast(BuildContext context, String message){

    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black38
    );

  }

  Future<void> getEmail() async {
    email = _auth.currentUser.email;
  }

  User getCurrentUser(){
    return _auth.currentUser;
  }

  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<void> sendVerificationEmail() async{

    _auth.currentUser.sendEmailVerification();

  }
}
