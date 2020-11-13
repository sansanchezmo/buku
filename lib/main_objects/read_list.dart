
import 'book.dart';

class ReadList{

  List<Book> _bookList;
  String _name;

  ReadList(this._name,this._bookList);

  String get name => _name;
  List<Book> get bookList => _bookList;
}