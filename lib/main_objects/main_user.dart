
import 'package:buku/firebase/auth.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku/main_objects/user.dart' as Usr;

class MainUser extends Usr.User{

  Auth _auth;
  Firestore _store;
  User _currUser;
  Usr.User _user;

  User get currUser => _currUser;
  Usr.User get user => _user;

  MainUser({loadUserInfo: true}) : super.empty(){

    _auth = Auth();
    _store = Firestore();
    _currUser = _auth.getCurrentUser();

    if(loadUserInfo){
      _setUser();
    }
  }

  void _setUser() async{
    _user = await _store.getUser(currUser.uid);
  }
  void login(String email, String password, BuildContext context) async{

    await _auth.loginUser(email, password, context);

  }

  void register(String email, String password, String nickName,
      BuildContext context) async{
    await _auth.registerUser(email, password, nickName, context);
    _currUser = _auth.getCurrentUser();
    await _store.createUser(_currUser.uid, nickName);

  }

  void signOut(BuildContext context) async{

    await _auth.signout();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);

  }

  void storeMainData(String theme, String name, String desc, String userImg, List<String> tags) async{

    await _store.storeMainData(_currUser.uid, theme, name, desc, userImg, tags);

  }
  @deprecated
  Future<String> getNickName() async{
    return null;
  }
  Future<String> getProfileTheme() async{
    return await _store.getData(currUser.uid,Firestore.theme);
  }
  @deprecated
  Future<String> getName() async{
    return null;
  }
  @deprecated
  Future<String> getDescription() async{
    return null;
  }
  @deprecated
  Future<String> getUserImage() async{
    return null;
  }
  @deprecated
  Future<List<String>> getTagList() async{
    return null;
  }
}