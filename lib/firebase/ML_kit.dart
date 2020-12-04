import 'dart:convert';
import 'dart:math';

import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/read_list.dart';
import 'package:buku/main_objects/structs/queue.dart';
import 'package:buku/main_objects/structs/set.dart';
import 'package:flutter/services.dart';

import 'ML_init.dart';

class ML{

  static final String authors = 'author';
  static final String tags = 'tag';

  static Queue<MiniBook> bookRecommendationQueue = Queue<MiniBook>();
  static Queue<String> tagRecommendationQueue = Queue<String>();
  static Queue<ReadList> readListRecommendationQueue = Queue<ReadList>();

  static UnorderedSet<String> userTags = UnorderedSet<String>();
  static UnorderedSet<String> userBooks = UnorderedSet<String>();
  static UnorderedSet<String> tagSet = UnorderedSet<String>();
  static UnorderedSet<String> authorSet = UnorderedSet<String>();

  static Map<String, dynamic> tagMap;
  static Map<String, dynamic> authorMap;

  static init({initData: true}) async{

    if(initData){
      tagMap = await loadData(tags);
      authorMap = await loadData(authors);
      tagSet.addAll(tagMap.keys);
      authorSet.addAll(authorMap.keys);
    }
    loadInitialTags();
    print('-------------------------------TAGS COMPLETE----------------------------------------------');
    loadInitialBooks();
    print('-------------------------------BOOKS COMPLETE----------------------------------------------');
    loadInitialReadList();
    print('-------------------------------READLIST COMPLETE----------------------------------------------');

  }

  static Future<String> getJson(String path) async{
    return rootBundle.loadString('database/$path');
  }

  static List<MiniBook> getRecommendedBooks(int i){
    List<MiniBook> list = [];

    /*while(list.length < i){
      while(!bookRecommendationQueue.empty() && list.length<i){
        list.add(bookRecommendationQueue.dequeue());
      }
      if(list.length<i){
        spanRecommendedBooks();
        randomRecommendedBooks(100);
      }
    }*/

    while(list.length < i){

      list.add(bookRecommendationQueue.dequeue());
      if(bookRecommendationQueue.length < 30){
        /*spanRecommendedBooks();
        randomRecommendedBooks(100);*/
        loadInitialBooks();
      }
    }
    return list;
  }

  static ArrayQueue<MiniBook> getRecommendedBookQueue(int i){
    ArrayQueue<MiniBook> queue = ArrayQueue<MiniBook>();

    while(queue.length < i){

      queue.enqueue(bookRecommendationQueue.dequeue());
      if(bookRecommendationQueue.length < 30){
        /*spanRecommendedBooks();
        randomRecommendedBooks(100);*/
        loadInitialBooks();
      }
    }
    return queue;

  }

  static List<ReadList> getRecommendedReadList(int i){

    List<ReadList> list = [];

    /*while(list.length <i){
      while(!tagRecommendationQueue.empty() && list.length<i){
        list.add(readListRecommendationQueue.dequeue());
      }
      if(list.length<i){
        spanRecommendedReadList(listsCount: 64);
      }
    }*/

    while(list.length<i){

      list.add(readListRecommendationQueue.dequeue());
      if(readListRecommendationQueue.length < 30){
        //spanRecommendedReadList(listsCount: 24);
        loadInitialReadList();
      }
    }

    return list;
  }

  static List<String> getRecommendedTags(int i){

    List<String> list = [];

    /*while(list.length <i){
      while(!tagRecommendationQueue.empty() && list.length<i){
        list.add(tagRecommendationQueue.dequeue());
      }
      if(list.length<i){
        spanRecommendedTags();
        randomRecommendedTags(100);
      }
    }*/

    while(list.length < i){
      list.add(tagRecommendationQueue.dequeue());
      if(tagRecommendationQueue.length < 30){
        //spanRecommendedTags();
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

  static loadInitialBooks(){

    var list = MLinit.getInitialBooks();

    for(MiniBook tag in list){

      bookRecommendationQueue.enqueue(tag);

    }
  }

  static loadInitialReadList(){

    var list = MLinit.getInitialReadList();

    for(ReadList tag in list){

      readListRecommendationQueue.enqueue(tag);

    }
  }

  static loadInitialTags(){

    var list = MLinit.getInitialTags();

    for(String tag in list){

      tagRecommendationQueue.enqueue(tag);

    }
  }

  /*static recommendedBooksByAuthor() async{

    List<MiniAuthor> userAuthors = MainUser.favAuthors;

    for(MiniAuthor author in userAuthors){
      List<dynamic> authorDictList = authorMap[author.name];
      
      for(var map in authorDictList){
        if(!userBooks.contains(map['isbn10'])){
          Book book = await Firestore().getBook(map['isbn_10'], userInitialize: false);
          MiniBook mini = book.toMiniBook();
          bookRecommendationQueue.enqueue(mini);
        }
      }
    }
  }*/

  /*static recommendedBooksByBook()async{

    for(MiniBook mini in MainUser.favBooks){
      Book book = await Firestore().getBook(mini.isbn10, userInitialize: false);

      for(dynamic tag in book.tags){
        List<dynamic> tagDictList = tagMap[tag.toString()];
        for(var map in tagDictList){
          if(!userBooks.contains(map['isbn_10'])){
            Book book = await Firestore().getBook(map['isbn_10'], userInitialize: false);
            MiniBook mini = book.toMiniBook();
            bookRecommendationQueue.enqueue(mini);
          }
        }
      }

      for(MiniAuthor author in book.authors){
        List<dynamic> authorDictList = authorMap[author.name];
        for(var map in authorDictList){
          if(!userBooks.contains(map['isbn_10'])){
            Book book = await Firestore().getBook(map['isbn_10'], userInitialize: false);
            MiniBook mini = book.toMiniBook();
            bookRecommendationQueue.enqueue(mini);
          }
        }
      }

    }
  }*/
  /*static recommendedBooksByTag() async{
    
    List<dynamic> tags = MainUser.tags;
    
    for(dynamic tag in tags){
      
      List<dynamic> tagDictList = tagMap[tag.toString()];
      
      for(var map in tagDictList){
        
        if(!userBooks.contains(map['isbn_10'])){
          if(!userBooks.contains(map['isbn10'])){
            Book book = await Firestore().getBook(map['isbn_10'], userInitialize: false);
            MiniBook mini = book.toMiniBook();
            bookRecommendationQueue.enqueue(mini);
          }
        }
      }
    }
  }*/

  /*static randomRecommendedBooks(int i) async{

    int count = 0;
    var random = Random();

    while(count<i){
      String isbn = tagMap['isbn'][random.nextInt(tagMap['isbn'].length)];
      Book book = await Firestore().getBook(isbn, userInitialize: false);
      bookRecommendationQueue.enqueue(book.toMiniBook());
      count++;
    }
  }*/

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

  /*static spanRecommendedBooks() async{

    for(MiniBook mini in MainUser.favBooks){
      userBooks.add(mini.isbn10);
    }
    
    await recommendedBooksByAuthor();
    await recommendedBooksByTag();
    await recommendedBooksByBook();

  }*/

  /*static spanRecommendedReadList({listsCount:4}) async{
    var random = Random();

    for(int i = 0; i<listsCount; i++){
      List<MiniBook> list = [];
      String tag = tagMap.keys.toList()[random.nextInt(tagMap.length)];
      if(tag == 'isbn') continue;
      else{
        List<dynamic> listMap = tagMap[tag];
        for(var map in listMap){
          Book book = await Firestore().getBook(map['isbn_10'], userInitialize: false);
          list.add(book.toMiniBook());
        }
        readListRecommendationQueue.enqueue(ReadList(tag,list));
      }
    }
  }*/

  /*static spanRecommendedTags() async{

    List<MiniBook> userBooks = MainUser.favBooks;
    for(dynamic tag in MainUser.tags){
      tag = tag.toString();
      userTags.add(tag);
    }

    for(MiniBook mini in userBooks){

      Book book = await Firestore().getBook(mini.isbn10, userInitialize: false);

      for(dynamic tag in book.tags){
        tag = tag.toString();
        if(!userTags.contains(tag)){
          tagRecommendationQueue.enqueue(tag);
        }
      }
    }
  }*/
}










