
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookHorizontalSlider extends StatefulWidget{
  String sliderTitle;
  List<MiniBook> miniBookList;
  BookHorizontalSlider(this.sliderTitle, this.miniBookList, {Key key}) : super(key: key);


  @override
  _BookHorizontalSliderState createState() => _BookHorizontalSliderState(this.sliderTitle, this.miniBookList);
  
}

class _BookHorizontalSliderState extends State<BookHorizontalSlider>{
  String sliderTitle;
  List<MiniBook> miniBookList;

  _BookHorizontalSliderState(this.sliderTitle, this.miniBookList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Container(
              height: 35,
              width: 45,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColorVariant,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
            Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  this.sliderTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: CurrentTheme.textColor3),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 220,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: _favBooksList(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _favBooksList() {
    List<Widget> userFavBooks = List<Widget>();
    for (int i = 0; i < 5; i++) {
      MiniBook book = this.miniBookList[i];
      String title = book.title, author = book.authors[0];
      userFavBooks.add(book.toWidget(context));
    }
    return userFavBooks;
  }
}