
import 'package:buku/scaffolds/others_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MiniBook{
  //Instance attributes
  String _isbn10;
  String _title;
  List<String> _authors;
  String _imageURL;

  //Constructor
  MiniBook(this._isbn10, this._title, this._authors, this._imageURL);

  //Getters
  String get isbn10 => _isbn10;
  String get title => _title;
  List<String> get authors => _authors;
  String get imageURL => _imageURL;

  //TODO: method toWidget.
  Widget toWidget(BuildContext context){
    return GestureDetector(
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookInfoScaffold(book: Firebase.getBook(this._isbn10))),
        );*/
      },
      child: Container(
        alignment: Alignment.center,
        width: 150,
        padding: EdgeInsets.only(right: 15, left: 15),
        child: Column(
          children: [
            //Book's image container
            Container(
              height: 130, width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(this._imageURL), fit: BoxFit.fill),
              ),
            ),
            SizedBox(height: 10),
            //Book's title
            Text(title.length > 35 ? title.substring(0,35) + "..." : title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: CurrentTheme.textColor2,
                )),
            SizedBox(height: 5),
            //Book's author
            /*Text(_authors.length > 30 ? _authors.substring(0,30) + "..." : _authors,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: CurrentTheme.textColor2,
                ))*/
          ],
        ),
      ),
    );
  }
}