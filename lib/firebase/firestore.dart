import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Firestore{

  static final String nickName = 'nickname';
  static final String theme = 'theme';
  static final String name = 'name';
  static final String description = 'desc';
  static final String userImgUrl = 'image_path';
  static final String tags = 'tags';
  static final String favoriteBooks = 'favorite_books';
  static final String searched = 'history';
  static final String followers = 'followers';
  static final String following = 'following';

  FirebaseFirestore store;

  Firestore(){
    store = FirebaseFirestore.instance;
  }

  // users methods ----------------------------------------------------------------------------

  void createUser(String uid, String nickName) async{

    await store.collection('users').doc(uid).set({
      'nickname' : nickName
    }).then((value) => print("user added"))
        .catchError((error) => throw Exception('there´s a problem with the user: Not created'));

  }

  void storeMainData(String uid, String theme, String name, String desc, String userImg, List<String> tags) async{
    await store.collection('users').doc(uid).update({
      'theme' : theme,
      'name' : name,
      'desc' : desc,
      'image_path' : userImg,
      'tags': tags
    }).catchError((error) => throw Exception('there´s a problem with the user: Data not stored'));

  }

  Future<dynamic> getData(String uid, String data) async {
    String nickName;
    await store.collection('users').doc(uid).get()
    .then((value) {
      nickName = value.data()[data];
    }).catchError((error) => throw Exception('No, we do not have $data data'));

    return nickName;

  }

  Future<List<Map<String,String>>> getFavAuthors(String uid) async{

    List<Map<String,String>> fav = [];
    await store.collection('users').doc(uid).collection('favorite_authors').get()
    .then((value) {
      value.docs.forEach((element) {
        fav.add(element.data());
      });
    });

    return fav;
  }

  Future<List<MiniBook>> getMiniBookCollection(String uid, String collectionName) async{
    List<MiniBook> list = [];
    await store.collection('users').doc(uid).collection(collectionName).get()
    .then((value) {
      value.docs.forEach((element) {
        var data = element.data();
        list.add(MiniBook(
          element.id,
          data['title'],
          data['authors'],
          data['image_url']
        ));
      });
    });

    return list;
  }

  Future<List<Map<String,String>>> getFollow(String uid, String collectionName) async{

    List<Map<String,String>> users = [];

    await store.collection('users').doc(uid).collection(collectionName).get()
    .then((value) {
      value.docs.forEach((element) {
        users.add(element.data());
      });
    });

    return users;

  }

  Future<bool> isNew(String uid) async{
    String item;
    await store.collection('users').doc(uid).get().then((doc) {
      item = doc.data()['theme'];
    });

    if(item == null) return true;

    return false;
  }

  Future<bool> checkName(String name) async{
    List<String> names = [];
    await store.collection('users').get().then((value) {
      value.docs.forEach((element) {names.add(element.data()[nickName]);});
    });

    for(int i = 0; i<names.length;i++){
      if(names[i] == name) return false;
    }
    return true;
  }

  // Books methods ----------------------------------------------------------------------------------------

  Future<Book> getBook(String isbn_10) async{

    String title, lan, year, publisher, desc, img;
    int views, pages;
    double rate;
    List<dynamic> authors, tags;
    List<dynamic> pdf;
    Map<String, dynamic> buy, isbn;

    await store.collection('books').doc(isbn_10).get().then((value) {
      var data = value.data();
      title = data['title'];
      lan = data['language'];
      year = data['year'].toString();
      publisher = data['publisher'];
      desc = data['desc'];
      img = data['image_url'];
      views = data['views']==null?0:data['views'];
      pages = data['pages'];
      rate = data['rate']['stars'];
      authors = data['authors'];
      tags = data['categories'];
      pdf = data['pdf_toread'];
      buy = data['buy'];
      isbn = data['identifier'];
    });

    List<BookComment> comments= [];

    await store.collection('books').doc(isbn_10).collection('comments').get().then((value) {
      value.docs.forEach((element) {
        var data = element.data();
        BookComment(data['user_uid'],data['user_name'],data['user_nickname'],data['user_image'],data['comment'],data['data']);
      });
    });

    Book book = Book(
      title,lan,year,publisher,desc,img,views,pages,
      rate,authors,tags,comments,pdf,buy,isbn
    );

    return book;

  }
}