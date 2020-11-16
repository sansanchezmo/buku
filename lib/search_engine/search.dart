import 'dart:convert';
import 'package:buku/firebase/ML_kit.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/tag.dart';
import 'package:buku/utilities/sort.dart';
import  'package:string_similarity/string_similarity.dart';
import 'package:buku/main_objects/structs/set.dart';
import 'package:flutter/services.dart';

class Search{

  static UnorderedSet<String> isbnSet = UnorderedSet<String>();
  static UnorderedSet<String> titleSet = UnorderedSet<String>();

  static Map<String,String> bookMap = {};

  static List<String> isbnList = [];
  static List<String> titleList = [];

  static init() async{

    await _loadISBN();
    await _loadTitle();
    _createBookSet();
    print('---------------COMPLETE SEARCH INIT----------------------');

  }

  static _createBookSet(){

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
      List<Map<String,dynamic>> books = _searchTitle(key);
      result.addAll(books);
    }
    List<Map<String,dynamic>> authors = _searchAuthor(key);
    result.addAll(authors);

    List<Map<String,dynamic>> results = _searchTag(key);
    result.addAll(results);

    result = Sort.sortResultMapBySimilarity(result);

    for(var map in result){

      if(map['type'] == 'book'){
        String isbn = bookMap[map['title']];
        try {
          Book book = await store.getBook(isbn.toUpperCase(), userInitialize: false);
          list.add(book.toMiniBook());
        }catch (e){
          print('failed to load isbn: '+isbn);
        }
      }
      else if(map['type'] == 'author'){
        String name = map['name'];
        list.add(MiniAuthor(name,'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'));
      }
      else if(map['type'] == 'tag'){
        list.add(Tag(map['title']));
      }
    }

    return list;

  }

  static List<MiniAuthor> searchAuthor(String key){

    List<MiniAuthor> list = [];
    List<Map<String,dynamic>> authors = _searchAuthor(key);

    for(var map in authors){

      String name = map['name'];
      list.add(MiniAuthor(name,'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'));
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

      List<Map<String,dynamic>> books = _searchTitle(key);
      for(var map in books){
        String isbn = bookMap[map['title']];
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