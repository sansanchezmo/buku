
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: emptyList widget

class BookHorizontalSlider extends StatefulWidget {
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
              height: 30,
              width: 40,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColorVariant,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
            SizedBox(width: 15),
            Text(
              this.sliderTitle,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: CurrentTheme.textColor3),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        this.miniBookList.length > 0? _favBooksScroll() : _emptyBookList()

      ],
    );
  }

  Widget _favBooksScroll() {
    List<Widget> userFavBooks = List<Widget>();
    for (int i = 0; i < this.miniBookList.length; i++) {
      MiniBook book = this.miniBookList[i];
      userFavBooks.add(book.toWidget(context));
    }
    return Container(
      height: 235,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: userFavBooks,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyBookList(){
    return Container(

    );
  }
}