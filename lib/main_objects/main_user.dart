
import 'package:buku/firebase/ML_kit.dart';
import 'package:buku/firebase/auth.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku/main_objects/user.dart' as Usr;

import 'mini_author.dart';
import 'mini_book.dart';

class MainUser{

  static Auth _auth;
  static Firestore _store;
  static User _currUser;
  static Usr.User _user;
  static Map<String, dynamic> _cache;

  static Auth get auth => _auth;
  static User get currUser => _currUser;
  static String get uid => _currUser== null ? null : _currUser.uid;
  static List<MiniBook> get openHistory => _user==null? null: _user.history;
  static List<MiniBook> get favBooks => _user==null? null: _user.favBooks;
  static List<MiniAuthor> get favAuthors => _user==null? null: _user.favAuthors;
  static List<dynamic> get tags => _user==null? null: _user.tags;
  static Usr.User get user => _user;
  static Map<String, dynamic> get cache => _cache;

  //initialize user attributes

  static init({loadUserInfo:true}) async{

    _auth = Auth();
    _store = Firestore();
    _currUser = _auth.getCurrentUser();

    if(loadUserInfo) {
      await _setUser();
      await _loadCache();
      //await ML.init();
    }

  }

  static Future<void> _loadCache() async{
    _cache = await _store.loadUserCache( uid);
  }

  static Future<Usr.User> _setUser() async{
    _user = await _store.getUser(currUser.uid);
    return _user;
  }

  //auth topic

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

  //user treatment

  static double currentBookRate(String isbn) {

    Map<String, dynamic> bookCache = _cache[isbn];

    if(bookCache == null) return 0.0;
    return bookCache['stars'] == null ? 0.0 : bookCache['stars'];

  }

  static Future<void> rateBook(String isbn, double stars) async{

    //Map<String, dynamic> bookCache = _cache[isbn];

    if(_cache[isbn] == null){
      _cache[isbn] = {};
    }

    _cache[isbn]['stars'] = stars;

    await _store.saveUserCache(uid,_cache);

  }

  static bool haveFavoriteBook(String isbn){

    if(_user == null) throw Exception('user not loaded yet');

    for(MiniBook book in user.favBooks){
      if(book.isbn10 == isbn) return true;
    }

    return false;
  }

  static Future<void> addBookToFavorites(MiniBook mini) async{
    await _store.addToMiniBookCollection(uid, Firestore.favoriteBooks, mini);
    await init();
  }

  static Future<void> addToOpenHistory(MiniBook mini) async{
    await _store.addToMiniBookCollection(uid, Firestore.openHistory, mini);
    await init();
  }

  static Future<void> removeBookFromFavorites(String isbn) async{
    await _store.removeFromMiniBookCollection(uid, Firestore.favoriteBooks, isbn);
    await init();
  }

  static Future<void> updateProfile(Map<String, dynamic> cache) async {
    await _store.updateUserInfo(uid, cache);
    await init();
  }

  static Future<void> setTheme(String option) async{

    await _store.setUserTheme(uid, option);

  }

  //get some useful data

  static Future<String> getNickName() async{
    return await _store.getData(currUser.uid,Firestore.theme);
  }

  static Future<String> getProfileTheme() async{
    return await _store.getData(currUser.uid,Firestore.theme);
  }

  //deprecated

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