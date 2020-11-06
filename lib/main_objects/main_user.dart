
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

  void signOut(BuildContext context) async{

    await _auth.signout();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);

  }

  void storeMainData(String theme, String name, String desc, String userImg, List<String> tags) async{

    await store.storeMainData(currUser.uid, theme, name, desc, userImg, tags);

  }

  Future<String> getNickName() async{

   return await store.getData(currUser.uid, Firestore.nickName);

  }
  Future<String> getProfileTheme() async{

    return await store.getData(currUser.uid, Firestore.theme);

  }

  Future<String> getName() async{

    return await store.getData(currUser.uid, Firestore.name);

  }

  Future<String> getDescription() async{

    return await store.getData(currUser.uid, Firestore.description);

  }

  Future<String> getUserImage() async{

    return await store.getData(currUser.uid, Firestore.userImgUrl);

  }

  Future<List<String>> getTagList() async{

    return await store.getData(currUser.uid, Firestore.tags);

  }
}