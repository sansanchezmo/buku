
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';

class User {

  String _uid, _name, _nickname, _description, _theme, _userImageUrl;
  List<MiniUser> _followers, _following;
  List<dynamic> _tags;
  List<MiniAuthor> _favAuthors;
  List<MiniBook> _favBooks, _history;
  Map<String,String> _statistics;

  User(
      this._uid,
      this._name,
      this._nickname,
      this._description,
      this._theme,
      this._userImageUrl,
      this._followers,
      this._following,
      this._tags,
      this._favAuthors,
      this._favBooks,
      this._history);


}
