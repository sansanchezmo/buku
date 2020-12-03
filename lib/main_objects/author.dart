import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';

class Author{
  String _name, _imageUrl, _bio, _birthDate;
  int _followers, _bookCount;
  List<MiniBook> _books;

  Author(this._name, this._imageUrl, this._bio, this._birthDate,
      this._followers, this._bookCount, this._books);

  String get name => _name;

  get imageUrl => _imageUrl;

  get bio => _bio;

  get birthDate => _birthDate;

  int get followers => _followers;

  get bookCount => _bookCount;

  List<MiniBook> get books => _books;

  MiniAuthor toMiniAuthor(){

    return MiniAuthor(_name, _imageUrl, _bookCount, _followers);

  }

}