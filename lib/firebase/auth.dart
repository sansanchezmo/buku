import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Import the firebase_core plugin


class Auth {

  FirebaseAuth _auth;

  Auth(){

    this._auth = FirebaseAuth.instance;

  }

  Future<void> registerUser(String email , String password, String nickName, BuildContext context) async {

    /*print(email);
    print(password);
    print(nickName);*/

    try{

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      if(userCredential != null){

        Navigator.of(context).pushNamed('/home');

      }

    } on FirebaseAuthException catch (e){

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }

  }

  Future<void> loginUser(String email, String password, BuildContext context) async{

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print("le logeo");
      if(userCredential != null){

        Navigator.of(context).pushNamed('/home');

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signout() async{

    await _auth.signOut();

  }

}