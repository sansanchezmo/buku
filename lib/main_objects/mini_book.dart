import 'dart:math';

import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/scaffolds/book_info_scaffolds/book_info_scf.dart';
import 'package:buku/theme/colors_list.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as FS;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiniBook {
  //Instance attributes
  String _isbn10;
  String _title;
  List<dynamic> _authors;
  String _imageURL;
  double _rate = 4.5;
  Color _color;

  //Constructor
  MiniBook(this._isbn10, this._title, this._authors, this._imageURL){
    Random rdm = new Random();
    this._color = ColorsList.colors[rdm.nextInt(5)];
  }

  //Getters
  String get isbn10 => _isbn10;
  String get title => _title;
  List<dynamic> get authors => _authors;
  String get imageURL => _imageURL;

  Widget toWidget(BuildContext context) {
    String authorsStr;
    if (_authors == [] || _authors == null) {
      authorsStr = "";
    } else {
      authorsStr = _authorNames();
    }

    return GestureDetector(
      onTap: () async {
        Book book = await Firestore().getBook(this._isbn10);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: 110,
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            //Book's image container
            miniBookImage(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: CurrentTheme.textColor3,
                      )),
                  SizedBox(height: 5),
                  //Book's author
                  Text(authorsStr,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 11,
                        color: CurrentTheme.textColor2,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toBigWidget(BuildContext context) {
    String authorsStr = _authorNames();
    return GestureDetector(
      onTap: () async {
        Book book = await Firestore().getBook(this._isbn10);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            SizedBox(height: 20),
            //Book's image container
            miniBookBigImage(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: CurrentTheme.textColor1,
                      )),
                  SizedBox(height: 5),
                  //Book's author
                  Text(authorsStr,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 15.5,
                        color: CurrentTheme.textColor3,
                      ))
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget miniBookImage({double width: 90}) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.all(5),
        height: width * 1.6,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Text(
          this.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: CurrentTheme.textColor3),
        ),
      ),
      Container(
        height: width * 1.6,
        width: width,
        decoration: BoxDecoration(
          color: CurrentTheme.shadow1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              image: NetworkImage(this._imageURL), fit: BoxFit.fill),
        ),
      ),
    ]);
  }

  Widget miniBookBigImage({double width: 180}) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: width * 1.6,
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            /*boxShadow: [
              BoxShadow(
                  color: CurrentTheme.shadow2, spreadRadius: 5, blurRadius: 15)
            ]*/),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              this._title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                  fontSize: 20, color: CurrentTheme.textColor3),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(child: SizedBox()),
            Text(
              _authorNames(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: CurrentTheme.textColor3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
      Container(
        height: width * 1.6,
        width: width,
        decoration: BoxDecoration(
          color: CurrentTheme.shadow2,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              image: NetworkImage(this._imageURL), fit: BoxFit.fill),
        ),
      ),
    ]);
  }

  Widget toResultWidget() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              miniBookImage(width: 75),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 190,
                      child: Text(this._title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: CurrentTheme.textColor1, fontSize: 16))),
                  SizedBox(height: 10),
                  Container(
                      width: 190,
                      child: Text(_authorNames(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: CurrentTheme.textColor3, fontSize: 14))),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      ratingStars(_rate),
                      SizedBox(
                        width: 10,
                      ),
                      Text(_rate.toString(),
                          style: TextStyle(
                              color: CurrentTheme.textColor3, fontSize: 14.5)),
                    ],
                  )
                ],
              ),
            ]));
  }

  Widget ratingStars(double rating) {
    /**
     * Returns the stars icons in a row, depending on the book´s rating.
     */
    double rat = rating;
    List<Widget> ratingStars = List<Widget>(5);
    for (int i = 0; i < 5; i++) {
      if (rat >= 1) {
        ratingStars[i] =
            Icon(Icons.star, color: CurrentTheme.primaryColor, size: 15.0);
      } else if (rat > 0) {
        ratingStars[i] =
            Icon(Icons.star_half, color: CurrentTheme.primaryColor, size: 15.0);
        rat = 0;
      } else if (rat <= 0) {
        ratingStars[i] = Icon(Icons.star_border,
            color: CurrentTheme.primaryColor, size: 15.0);
      }
      rat--;
    }
    return Row(children: ratingStars);
  }

  String _authorNames() {
    String names = this._authors[0];
    for (int i = 1; i < this._authors.length; i++) {
      names = names + ", " + this._authors[i];
    }
    return names;
  }
}

class TimeMiniBook extends MiniBook implements Comparable<TimeMiniBook> {
  FS.Timestamp _time;

  FS.Timestamp get time => _time;

  TimeMiniBook(
      String isbn10, String title, List authors, String imageURL, this._time)
      : super(isbn10, title, authors, imageURL);

  @override
  int compareTo(TimeMiniBook other) {
    return time.compareTo(other.time);
  }
}
