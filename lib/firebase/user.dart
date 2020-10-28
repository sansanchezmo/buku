
import 'package:buku/firebase/auth.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MainUser {

  Auth _auth;
  Firestore store;
  User currUser;

  MainUser(){
    _auth = Auth();
    store = Firestore();
    currUser = _auth.getCurrentUser();
  }

  void login(String email, String password, BuildContext context) async{

    await _auth.loginUser(email, password, context);

  }

  void register(String email, String password, String nickName,
      BuildContext context) async{
    await _auth.registerUser(email, password, nickName, context);
    currUser = _auth.getCurrentUser();
    await store.createUser(currUser.uid, nickName);

  }

}