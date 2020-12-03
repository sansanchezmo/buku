import 'package:buku/main_objects/user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class MiniUser {

  String _uid, _name, _nickname, _imagePath;

  MiniUser(this._uid, this._name, this._nickname, this._imagePath);

  String get uid => _uid;
  String get name => _name;
  String get nickname => _nickname;
  String get imagePath => _imagePath;

}

