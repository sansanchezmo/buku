import 'dart:convert';
import 'package:buku/firebase/ML_kit.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/author.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/tag.dart';
import 'package:buku/utilities/sort.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:buku/main_objects/structs/set.dart';
import 'package:buku/main_objects/structs/map.dart';
import 'package:buku/main_objects/structs/trie.dart';
import 'package:buku/main_objects/structs/heap.dart';
import 'package:buku/main_objects/structs/bk_tree.dart';
import 'package:flutter/services.dart';

class Search{

  static UnorderedSet<String> isbnSet = UnorderedSet<String>();
  static UnorderedSet<String> titleSet = UnorderedSet<String>();

  //static UnorderedMap<String,String> bookMap;
  static Map<String,String> bookMap = {};
  static Trie bookTrie;
  static BKTree bookBKTree;

  static BKTree userBKTree;

  static List<String> isbnList = [];
  static List<String> titleList = [];

  static init() async{

    await _loadISBN();
    await _loadTitle();
    _createBookSet();
    _createBookTrie(); // 7-10 seconds
    _createUserBKTree(); // We don't have a lot of users, so this is quite fast
    //_createBookBKTree(); // JUST TOO SLOW
    print('---------------COMPLETE SEARCH INIT----------------------');

  }

  static _createUserBKTree() {

    userBKTree = new BKTree();
    Firestore().getUsersBKTree();

  }


  static _createBookBKTree() {

    bookBKTree = new BKTree();

    bookMap.forEach((isbn, title) {
      bookBKTree.add(new BKTreeNode(title, isbn));
    });

  }

  static _createBookTrie() {

    bookTrie = new Trie();

    bookMap.forEach((isbn, title) {
      bookTrie.add(title, isbn);
    });

  }

  static _createBookSet(){

    //bookMap = new UnorderedMap<String,String>();

    for(int i=0; i<isbnList.length;i++){

      //bookMap[titleList[i]] = isbnList[i];
      bookMap[isbnList[i]] = titleList[i];

    }
  }

  static _loadISBN() async{

    String isbn = await rootBundle.loadString('database/isbnList.txt');
    isbnList = LineSplitter().convert(isbn).map((e) => e.toString()).toList();
    isbnSet.addAll(isbnList);

  }

  static _loadTitle() async{

    String title = await rootBundle.loadString('database/titleList.txt');
    titleList = LineSplitter().convert(title).map((e) => e.toString()).toList();
    titleSet.addAll(titleList);

  }

  static Future<List<dynamic>> search(String key) async{

    var store = Firestore();
    List<dynamic> list = [];
    List<Map<String,dynamic>> result = [];

    if(_searchISBN(key)){
      var book = await store.getBook(key);
      list.add(book.toMiniBook());
      return list;
    }else{
      List<dynamic> books = _searchPrefixTitle(key);
      List<Map<String, dynamic>> map = [];
      for(var book in books){
        map.add({'isbn': book[1], 'similarity':0.9,'type':'book'});
      }
      result.addAll(map);
    }
    List<Map<String,dynamic>> authors = _searchAuthor(key);
    result.addAll(authors);

    List<Map<String,dynamic>> results = _searchTag(key);
    result.addAll(results);

    result = Sort.sortResultMapBySimilarity(result);

    for(var map in result){

      if(map['type'] == 'book'){
        String isbn = map['isbn'];
        try {
          Book book = await store.getBook(isbn.toUpperCase(), userInitialize: false);
          list.add(book.toMiniBook());
        }catch (e){
          print('failed to load isbn: '+isbn);
        }
      }
      else if(map['type'] == 'author'){
        String name = map['name'];
        Author author = await store.getAuthor(name);

        list.add(author.toMiniAuthor());
      }
      else if(map['type'] == 'tag'){
        list.add(Tag(map['title']));
      }
    }

    return list;

  }

  static Future<List<MiniAuthor>> searchAuthor(String key) async{
    var store = Firestore();

    List<MiniAuthor> list = [];
    List<Map<String,dynamic>> authors = _searchAuthor(key);

    for(var map in authors){

      String name = map['name'];
      Author author = await store.getAuthor(name);
      list.add(author.toMiniAuthor());
    }

    return list;

  }

  static Future<List<MiniBook>> searchBook(String key) async{
    var store = Firestore();
    List<MiniBook> list = [];
    if(_searchISBN(key)){
      var book = await store.getBook(key, userInitialize: false);
      list.add(book.toMiniBook());
    }else{

      List<dynamic> books = _searchPrefixTitle(key);
      for(var find in books){
        String isbn = find[1];
        try {
          Book book = await store.getBook(isbn.toUpperCase(), userInitialize: false);
          list.add(book.toMiniBook());
        }catch (e){
          print(isbn);
        }
      }
    }
    return list;

  }

  static List<Tag> searchTag(String key){

    List<Tag> list = [];
    List<Map<String,dynamic>> results = _searchTag(key);


    for(var map in results){

      list.add(Tag(map['title']));

    }
    return list;
  }

  static _searchAuthor(String name){

    List<Map<String,dynamic>> results = [];

    ML.authorSet.forEach((element) {
      double similarity = name.trim().toLowerCase().similarityTo(element.trim().toLowerCase());
      if(element.trim().toLowerCase() == name.trim().toLowerCase()){
        results.add({'name':element, 'similarity': 1.0, 'type' :'author'});
      }
      else if(element.trim().toLowerCase().contains(name.trim().toLowerCase())){
        results.add({'name':element, 'similarity': 0.9, 'type' :'author'});
      }
      else if(similarity >= 0.5){
        results.add({'name':element, 'similarity': similarity, 'type' :'author'});
      }
    });

    results = Sort.sortResultMapBySimilarity(results);
    results = results.take(15).toList();

    return results;

  }

  static _searchISBN(String isbn){

    return isbnSet.contains(isbn);

  }

  static _searchPrefixTitle(String title) => bookTrie.prefixSearch(title);

  static _searchTitle(String title){

    List<Map<String,dynamic>> results = [];

    //bool found = false;

    titleSet.forEach((element) {
      /*if(element.trim().toLowerCase() == title.trim().toLowerCase()){
        found =  true;
      }*/
      double similarity = title.trim().toLowerCase().similarityTo(element.trim().toLowerCase());
      if(element.trim().toLowerCase() == title.trim().toLowerCase()){
        results.add({'title':element, 'similarity': 1.0, 'type' :'book'});
      }
      else if(element.trim().toLowerCase().contains(title.trim().toLowerCase())){
        results.add({'title':element, 'similarity': 0.9, 'type' :'book'});
      }
      else if(similarity >= 0.5){
        results.add({'title':element, 'similarity': similarity, 'type' :'book'});
      }
    });

    results = Sort.sortResultMapBySimilarity(results);
    results = results.take(15).toList();

    return results;

  }

  static _searchTag(String tag){

    List<Map<String,dynamic>> results = [];

    ML.tagSet.forEach((element) {
      double similarity = tag.trim().toLowerCase().similarityTo(element.trim().toLowerCase());
      if(element.trim().toLowerCase() == tag.trim().toLowerCase()){
        results.add({'title':element, 'similarity': 1.0, 'type' :'tag'});
      }
      else if(element.trim().toLowerCase().contains(tag.trim().toLowerCase())){
        results.add({'title':element, 'similarity': 0.9, 'type' :'tag'});
      }
      else if(similarity >= 0.5){
        results.add({'title':element, 'similarity': similarity, 'type' :'tag'});
      }
    });

    results = Sort.sortResultMapBySimilarity(results);
    results = results.take(15).toList();

    return results;
  }

  static _searchUser(String query, {int tolerance = 1}) => userBKTree.searchSuggestions(query, tolerance);

  /*static searchTagDict(String tag){

    List<Map<String,dynamic>> results = [];

    ML.tagSet.forEach((element) {
      double similarity = tag.trim().toLowerCase().similarityTo(element.trim().toLowerCase());
      if(element.trim().toLowerCase() == tag.trim().toLowerCase()){
        results.add({'title':element, 'similarity': 1.0, 'type' :'tag'});
      }
      else if(element.trim().toLowerCase().contains(tag.trim().toLowerCase())){
        results.add({'title':element, 'similarity': 0.9, 'type' :'tag'});
      }
      else if(similarity >= 0.5){
        results.add({'title':element, 'similarity': similarity, 'type' :'tag'});
      }
    });

    //results = results.take(15).toList();

    results = Sort.sortResultMapBySimilarity(results);

    return results;
  }*/
}
