import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/main_objects/user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Firestore{

  static final String nickname = 'nickname';
  static final String theme = 'theme';
  static final String name = 'name';
  static final String biography = 'desc';
  static final String userImgPath = 'image_path';
  static final String tags = 'tags';
  static final String favoriteBooks = 'favorite_books';
  static final String openHistory = 'open_history';
  static final String followers = 'followers';
  static final String following = 'following';

  FirebaseFirestore store;

  Firestore(){
    store = FirebaseFirestore.instance;
  }

  //GETTERS////////////////////////////////////////////////////////////////////////////////////

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

  Future<User> getUser(String uid) async{

    List<MiniAuthor> favAuthors = await getFavAuthors(uid);
    List<MiniBook> favBooks = await getMiniBookCollection(uid, Firestore.favoriteBooks);
    List<MiniBook> history = await getMiniBookCollection(uid, Firestore.openHistory);
    List<MiniUser> following = await getFollow(uid, Firestore.following);
    List<MiniUser> followers = await getFollow(uid, Firestore.followers);

    Map<String,String> statistics = {
      'books':FormatString.formatStatistic(favBooks.length),
      'followers':FormatString.formatStatistic(followers.length),
      'following':FormatString.formatStatistic(following.length)
    };

    User user;
    await store.collection('users').doc(uid).get()
    .then((value) {
      var data = value.data();
      user = User(
        uid,
        data['name'],
        data['nickname'],
        data['desc'],
        data['theme'],
        data['image_path'],
        followers,
        following,
        data['tags'],
        favAuthors,
        favBooks,
        history,
        statistics
      );
    });

    return user;

  }

  Future<dynamic> getData(String uid, String data) async {
    String nickName;
    await store.collection('users').doc(uid).get()
    .then((value) {
      nickName = value.data()[data];
    }).catchError((error) => throw Exception('No, we do not have $data data'));

    return nickName;

  }

  Future<List<MiniAuthor>> getFavAuthors(String uid) async{

    List<MiniAuthor> fav = [];
    await store.collection('users').doc(uid).collection('favorite_authors').get()
    .then((value) {
      value.docs.forEach((element) {
        var data = element.data();
        fav.add(MiniAuthor(
          data['name'],
          data['image_url']
        ));
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

  Future<List<MiniUser>> getFollow(String uid, String collectionName) async{

    List<MiniUser> users = [];

    await store.collection('users').doc(uid).collection(collectionName).get()
    .then((value) {
      value.docs.forEach((element) {
        var data = element.data();
        users.add(MiniUser(
          element.id,
          data['name'],
          data['nickname'],
          data['image_path']
        ));
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
      value.docs.forEach((element) {names.add(element.data()[nickname]);});
    });

    for(int i = 0; i<names.length;i++){
      if(names[i] == name) return false;
    }
    return true;
  }

  Future<Map<String, dynamic>> loadUserCache(String uid) async{
    Map<String, dynamic> map = {};

    await store.collection('users').doc(uid).get()
    .then((value) {
      map = value.data()['cache'];
    });

    if(map == null) map = {};

    return map;

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

    List<MiniAuthor> authorList = [];
    for( dynamic author in authors){ //TODO: add real author images
      authorList.add(
        MiniAuthor(
          author.toString(),
          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
        )
      );
    }

    List<BookComment> comments= []; //TODO: sort comments by date

    await store.collection('books').doc(isbn_10).collection('comments').get().then((value) {
      value.docs.forEach((element) {
        var data = element.data();
        BookComment(data['user_uid'],data['user_name'],data['user_nickname'],data['user_image'],data['comment'],data['date']);
      });
    });

    Book book = Book(
      title,lan,year,publisher,desc,img,views,pages,
      rate,authorList,tags,comments,pdf,buy,isbn
    );

    return book;

  }

  //SETTERS///////////////////////////////////////////////////////////////////////////////////////

  //user methods-------------------------------------------------------------------

  Future<void> addToMiniBookCollection(String uid, String collectionName, MiniBook mini) async{

    await store.collection('users').doc(uid).collection(collectionName).doc(mini.isbn10).set({
      'authors' : mini.authors,
      'image_url' : mini.imageURL,
      'title' : mini.title
    });

  }

  Future<void> removeFromMiniBookCollection(String uid, String collectionName, String isbn) async{

    await store.collection('users').doc(uid).collection(collectionName).doc(isbn).delete();

  }

  Future<void> updateUserInfo(String uid,Map<String,dynamic> cache) async{

    await store.collection('users').doc(uid).update(cache);

  }

  Future<void> setUserTheme(String uid, String option) async{

    if(option != CurrentTheme.orangeTheme && option != CurrentTheme.darkTheme) throw Exception('Invalid theme');

    await store.collection('users').doc(uid).update({
      'theme' : option
    });

  }

  Future<void> saveUserCache(String uid, Map<String, dynamic> map) async{

    await store.collection('users').doc(uid).update({
      'cache' : map
    });

  }

  //book method----------------------------------------------------------------------------------------------

  Future<void> rateBook(String isbn, double stars, double currentUserRate) async{

    int numUser;
    double sumStars;

    var bookRef = store.collection('books').doc(isbn);

    await bookRef.get()
    .then((value) {
      var data = value.data()['rate'];
      numUser = data['num_users'];
      sumStars = data['sum_stars'];
    });

    numUser+=1;
    sumStars= sumStars + stars - currentUserRate;
    stars = sumStars/numUser;

    String starsText = stars.toStringAsFixed(2);
    stars = double.parse(starsText);

    await bookRef.update({
      'rate': {
        'num_users' : numUser,
        'stars' : stars,
        'sum_stars' : sumStars
      }
    });
  }

  Future<void> updateBookViews(String isbn) async{

    int views;

    var bookRef = store.collection('books').doc(isbn);

    await bookRef.get()
    .then((value) {
      var data = value.data();
      views = data['views'];
    });

    if(views == null) views = 1;
    else views+=1;

    await bookRef.update({
      'views' : views
    });

  }

  Future<void> addComment(String isbn, BookComment bc) async{

    await store.collection('books').doc(isbn).collection('comments').add({
      'user_uid':bc.userUID,
      'user_name': bc.userName,
      'user_nickname' : bc.userNickName,
      'user_image' : bc.userProfilePic,
      'comment' : bc.comment,
      'date' : bc.date
    });
  }
}