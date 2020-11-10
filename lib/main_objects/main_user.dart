
import 'package:buku/firebase/auth.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku/main_objects/user.dart' as Usr;

import 'mini_book.dart';

class MainUser{

  static Auth _auth;
  static Firestore _store;
  static User _currUser;
  static Usr.User _user;

  static Auth get auth => _auth;
  static User get currUser => _currUser;
  static String get uid => _currUser.uid;
  static Usr.User get user => _user;

  static init({loadUserInfo:true}) async{

    _auth = Auth();
    _store = Firestore();
    _currUser = _auth.getCurrentUser();

    if(loadUserInfo) await _setUser();

  }

  static Future<Usr.User> _setUser() async{
    _user = await _store.getUser(currUser.uid);
    return _user;
  }
  static void login(String email, String password, BuildContext context) async{
    await _auth.loginUser(email, password, context);
    await init();
  }

  static void register(String email, String password, String nickName,
      BuildContext context) async{
    await _auth.registerUser(email, password, nickName, context);
    _currUser = _auth.getCurrentUser();
    await _store.createUser(_currUser.uid, nickName);

  }

  static void signOut(BuildContext context) async{

    await _auth.signout();
    _auth = null;
    _store = null;
    _currUser = null;
    _user = null;
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);

  }

  static void storeMainData(String theme, String name, String desc, String userImg, List<String> tags) async{

    await _store.storeMainData(_currUser.uid, theme, name, desc, userImg, tags);
    await MainUser.init();

  }

  static bool haveFavoriteBook(String isbn){

    if(_user == null) throw Exception('user not loaded yet');

    for(MiniBook book in user.favBooks){
      if(book.isbn10 == isbn) return true;
    }

    return false;
  }

  static Future<void> updateProfile(Map<String, dynamic> cache) async{

    await _store.updateUserInfo(uid, cache);
    await init();

  }

  static Future<void> setTheme(String option) async{

    await _store.setUserTheme(uid, option);

  }

  static Future<String> getNickName() async{
    return await _store.getData(currUser.uid,Firestore.theme);
  }

  static Future<String> getProfileTheme() async{
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