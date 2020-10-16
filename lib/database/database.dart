
import 'dart:io';

import 'package:buku/initialization/mainObjects/book.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class Database {

  static Future<void> createDatabase() async{

    //pls don't delete this function, it's used to create the database

    String _dir = await getDatabasesPath();
    String _path = _dir + 'buku_database.db';

    await deleteDatabase(_path);

    ByteData data = await rootBundle.load("database/buku_database.db");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(_path).writeAsBytes(bytes);

    print('-----------------------------------Database successfully created-----------------------------');

  }

  static dynamic openConnection() async{

    String _dir = await getDatabasesPath();
    String _path = _dir + 'buku_database.db';

    var _db = await openDatabase(_path);

    List<Map> _book_count = await _db.rawQuery('SELECT count(rowid) FROM book');
    return [_db, _book_count[0]['count(rowid)']];

  }

  static Future<int> getBookCount() async{

    dynamic res = await openConnection();
    int _bookCount = res[1];
    res[0].close();

    return _bookCount;

  }

  static Future<List<Book>> getBookList(int n) async{

    dynamic res = await openConnection();

    var _db = res[0];
    int numBooks = res[1];

    if (n>numBooks){
      throw Exception('there are not enough data in db');
    }

    List<Map> _bookData = await _db.rawQuery('SELECT * FROM book LIMIT '  + n.toString());

    List<Book> list = List();

    for(Map row in _bookData){

      Book newBook = Book(row['book_ISBN'],row['book_name'],row['book_author'],row['book_year'],row['book_publisher'],'',row['book_simage'],
          row['book_mimage'],row['book_himage']);

      list.add(newBook);

    }

    await _db.close();

    return list.take(n).toList();

  }

}

