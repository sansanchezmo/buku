
import 'package:buku/main_objects/mini_book.dart';

import 'book.dart';

class ReadList{

  List<MiniBook> _bookList;
  String _name;

  ReadList(this._name,this._bookList);

  String get name => _name;
  List<MiniBook> get bookList => _bookList;
}