import 'package:buku/main_objects/book.dart';
import 'package:buku/scaffolds/book_info_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:buku/firebase/firestore.dart' as FS;
import 'package:flutter/material.dart';

import 'mini_book.dart';
import 'mini_user.dart';

class Publication {
  String _text;
  Timestamp _date;
  MiniUser _user;
  MiniBook _book;

  Publication(this._user, this._text, this._date , this._book);

  Widget toWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          _userInfoWidget(),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CurrentTheme.backgroundContrast,
                borderRadius: BorderRadius.all(Radius.circular(10))),
              child: this._book == null?
              _publicationText() :
              _textWithBook(context)
          ),
          SizedBox(height: 10),
      Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Text(
          this._date.toDate().toString(),

          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: CurrentTheme.textColor3,
            fontSize: 13
          ),
        ),
      )
        ],
      ),

    );
  }

  Widget _userInfoWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProfileAvatar(size: 40,profileImage: this._user.imagePath,),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 270,
              padding: EdgeInsets.only(right: 20),
              child: Text(this._user.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 15,
                      color: CurrentTheme.textColor1
                  )),
            ),
            Text("@" + this._user.nickname,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
                style: TextStyle(
                    fontSize: 13,
                    color: CurrentTheme.textColor2
                )),
          ],
        )
      ],
    );
  }

  Widget _textWithBook(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            Book book = await FS.Firestore().getBook(this._book.isbn10);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
            );
          },
          child: this._book.miniBookImage(),
        ),
        SizedBox(width: 15),
        Container(
          width: 185,
          child: _publicationText())
      ],
    );
  }

  Widget _publicationText(){
    return Text(
      this._text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 15,
        color: CurrentTheme.textColor3,
      ),
    );
  }

}