import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'mini_book.dart';
import 'mini_user.dart';

class Publication {
  String _text;
  Timestamp _date;
  MiniUser _user;
  MiniBook _book;

  Publication(this._user, this._text, this._date , this._book);

  Widget toWidget(){

  }
}