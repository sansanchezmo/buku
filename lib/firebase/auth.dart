import 'package:buku/main_objects/main_user.dart';
import 'package:buku/scaffolds/init_scaffolds/login_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'firestore.dart';
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

        await sendVerificationEmail();
        userCredential.user.updateProfile(displayName: nickName);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => LoginScaffold(email: email,pass: password)
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

          if(isNew){
            Navigator.of(context).pushNamed('/newUser');

          }else{
            String theme = await MainUser.getProfileTheme();
            CurrentTheme.setTheme(theme, context: context);
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
        backgroundColor: CurrentTheme.background,
        title: Text(title, style: TextStyle(color: CurrentTheme.textColor1, fontWeight: FontWeight.bold),),
        content: Text(message, style: TextStyle(color: CurrentTheme.textColor2),),
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

    await _auth.currentUser.sendEmailVerification();

  }
}
