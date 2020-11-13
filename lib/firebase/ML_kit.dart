import 'dart:convert';
import 'dart:math';

import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/structs/queue.dart';
import 'package:buku/main_objects/structs/set.dart';
import 'package:flutter/services.dart';

class ML{

  static final String authors = 'author';
  static final String tags = 'tag';

  static Queue<MiniBook> bookRecommendationQueue = Queue<MiniBook>();
  static Queue<String> tagRecommendationQueue = Queue<String>();
  static Queue<List<Book>> readListRecommendationQueue = Queue<List<Book>>();

  static UnorderedSet<String> userTags = UnorderedSet<String>();
  static UnorderedSet<String> userBooks = UnorderedSet<String>();

  static Map<String, dynamic> tagMap;
  static Map<String, dynamic> authorMap;

  static init({initData: true}) async{

    if(initData){
      tagMap = await loadData(tags);
      authorMap = await loadData(authors);
    }
    await spanRecommendedTags();
    randomRecommendedTags(100);
    await spanRecommendedBooks();
    await randomRecommendedBooks(100);
    await spanRecommendedReadList(listsCount: 16);

  }

  static Future<String> getJson(String path) async{
    return rootBundle.loadString('database/$path');
  }

  static List<MiniBook> getRecommendedBooks(int i){
    List<MiniBook> list = [];

    while(list.length < i){
      while(!bookRecommendationQueue.empty() && list.length<i){
        list.add(bookRecommendationQueue.dequeue());
      }
      if(list.length<i){
        spanRecommendedBooks();
        randomRecommendedBooks(100);
      }
    }

    return list;
  }

  static List<List<Book>> getRecommendedReadList(int i){

    List<List<Book>> list = [];

    while(list.length <i){
      while(!tagRecommendationQueue.empty() && list.length<i){
        list.add(readListRecommendationQueue.dequeue());
      }
      if(list.length<i){
        spanRecommendedReadList(listsCount: 64);
      }
    }

    return list;
  }

  static List<String> getRecommendedTags(int i){

    List<String> list = [];

    while(list.length <i){
      while(!tagRecommendationQueue.empty() && list.length<i){
        list.add(tagRecommendationQueue.dequeue());
      }
      if(list.length<i){
        spanRecommendedTags();
        randomRecommendedTags(100);
      }
    }

    return list;
  }

  static Future<Map<String, dynamic>> loadData(String dataName) async{

    String path = dataName + '_dict.json';

    var loaded = await getJson(path);

    Map<String, dynamic> data = json.decode(loaded);

    return data;

  }

  static recommendedBooksByAuthor() async{

    List<MiniAuthor> userAuthors = MainUser.favAuthors;

    for(MiniAuthor author in userAuthors){
      List<dynamic> authorDictList = authorMap[author.name];
      
      for(var map in authorDictList){
        if(!userBooks.contains(map['isbn10'])){
          Book book = await Firestore().getBook(map['isbn_10']);
          MiniBook mini = book.toMiniBook();
          bookRecommendationQueue.enqueue(mini);
        }
      }
    }
  }

  static recommendedBooksByBook()async{

    for(MiniBook mini in MainUser.favBooks){
      Book book = await Firestore().getBook(mini.isbn10);

      for(dynamic tag in book.tags){
        List<dynamic> tagDictList = tagMap[tag.toString()];
        for(var map in tagDictList){
          if(!userBooks.contains(map['isbn_10'])){
            Book book = await Firestore().getBook(map['isbn_10']);
            MiniBook mini = book.toMiniBook();
            bookRecommendationQueue.enqueue(mini);
          }
        }
      }

      for(MiniAuthor author in book.authors){
        List<dynamic> authorDictList = authorMap[author.name];
        for(var map in authorDictList){
          if(!userBooks.contains(map['isbn_10'])){
            Book book = await Firestore().getBook(map['isbn_10']);
            MiniBook mini = book.toMiniBook();
            bookRecommendationQueue.enqueue(mini);
          }
        }
      }

    }
  }
  static recommendedBooksByTag() async{
    
    List<dynamic> tags = MainUser.tags;
    
    for(dynamic tag in tags){
      
      List<dynamic> tagDictList = tagMap[tag.toString()];
      
      for(var map in tagDictList){
        
        if(!userBooks.contains(map['isbn_10'])){
          if(!userBooks.contains(map['isbn10'])){
            Book book = await Firestore().getBook(map['isbn_10']);
            MiniBook mini = book.toMiniBook();
            bookRecommendationQueue.enqueue(mini);
          }
        }
      }
    }
  }

  static randomRecommendedBooks(int i) async{

    int count = 0;
    var random = Random();

    while(count<i){
      String isbn = tagMap['isbn'][random.nextInt(tagMap['isbn'].length)];
      Book book = await Firestore().getBook(isbn);
      bookRecommendationQueue.enqueue(book.toMiniBook());
      count++;
    }
  }

  static randomRecommendedTags(int i){

    int count = 0;
    var random = Random();

    while(count<i){
      String tag = tagMap.keys.toList()[random.nextInt(tagMap.length)];
      if(!userTags.contains(tag) && tag != 'isbn'){
        tagRecommendationQueue.enqueue(tag);
        count++;
      }
    }
  }

  static spanRecommendedBooks() async{

    for(MiniBook mini in MainUser.favBooks){
      userBooks.add(mini.isbn10);
    }
    
    await recommendedBooksByAuthor();
    await recommendedBooksByTag();
    await recommendedBooksByBook();

  }

  static spanRecommendedReadList({listsCount:4}) async{
    var random = Random();

    for(int i = 0; i<listsCount; i++){
      List<Book> list = [];
      String tag = tagMap.keys.toList()[random.nextInt(tagMap.length)];
      if(tag == 'isbn') continue;
      else{
        List<dynamic> listMap = tagMap[tag];
        for(var map in listMap){
          Book book = await Firestore().getBook(map['isbn_10']);
          list.add(book);
        }
        readListRecommendationQueue.enqueue(list);
      }
    }
  }

  static spanRecommendedTags() async{

    List<MiniBook> userBooks = MainUser.favBooks;
    for(dynamic tag in MainUser.tags){
      tag = tag.toString();
      userTags.add(tag);
    }

    for(MiniBook mini in userBooks){

      Book book = await Firestore().getBook(mini.isbn10);

      for(dynamic tag in book.tags){
        tag = tag.toString();
        if(!userTags.contains(tag)){
          tagRecommendationQueue.enqueue(tag);
        }
      }
    }
  }
}










