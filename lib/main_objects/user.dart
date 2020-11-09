
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

  User.empty();

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
      this._history,
      this._statistics);

  Map<String, String> get statistics => _statistics;

  get history => _history;

  List<MiniBook> get favBooks => _favBooks;

  List<MiniAuthor> get favAuthors => _favAuthors;

  List<dynamic> get tags => _tags;

  get following => _following;

  List<MiniUser> get followers => _followers;

  get userImageUrl => _userImageUrl;

  get theme => _theme;

  get description => _description;

  get nickname => _nickname;

  get name => _name;

  String get uid => _uid;
}
