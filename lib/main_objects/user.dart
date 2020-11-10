import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';

class User {

  /**
   * Contains a user complete info. It is used to build user profile.
   */

  ///Attributes
  String _uid, _name, _nickname, _description, _theme, _imageUrl;
  List<MiniUser> _followers, _following;
  List<dynamic> _tags;
  List<MiniAuthor> _favAuthors;
  List<MiniBook> _favBooks, _history;
  Map<String,String> _statistics;

  ///Constructor
  User(
      this._uid,
      this._name,
      this._nickname,
      this._description,
      this._theme,
      this._imageUrl,
      this._followers,
      this._following,
      this._tags,
      this._favAuthors,
      this._favBooks,
      this._history,
      this._statistics);

  ///Getters
  String get uid => _uid;
  String get imageUrl => _imageUrl;
  String get theme => _theme;
  String get description => _description;
  String get nickname => _nickname;
  String get name => _name;
  List<MiniUser> get following => _following;
  List<MiniUser> get followers => _followers;
  List<MiniBook> get history => _history;
  List<MiniBook> get favBooks => _favBooks;
  List<MiniAuthor> get favAuthors => _favAuthors;
  List<dynamic> get tags => _tags;
  Map<String, String> get statistics => _statistics;

  ///------------------------Public Method----------------------------///
  List<Widget> tagsToWidget(){
    /**
     * Returns a list of widgets. Each widget is a tag inside a container.
     */
    List<Widget> favTagsWidgets = new List<Widget>();
    for (int i = 0; i < tags.length; i++) {
      favTagsWidgets.add(Container(
        height: 33,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: CurrentTheme.backgroundContrast,
            border: Border.all(color: CurrentTheme.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          tags[i] == null ? "null" : tags[i],
          style: TextStyle(color: CurrentTheme.textColor2, fontSize: 13),
        ),
      ));
      favTagsWidgets.add(SizedBox(width: 10, height: 40));
    }
    return favTagsWidgets;
  }
}
