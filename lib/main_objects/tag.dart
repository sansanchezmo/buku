import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';

class Tag {
  String _text;

  Tag(this._text);

  String get text => _text;

  Widget toWidget(){
    return Container(
      height: 35,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: CurrentTheme.background,
          border: Border.all(color: CurrentTheme.primaryColorVariant),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Text(
        _text,
        style: TextStyle(color: CurrentTheme.textColor1, fontSize: 14),
      ),
    );
  }
}