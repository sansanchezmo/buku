import 'package:buku/main_objects/book.dart';
import 'package:buku/scaffolds/others_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookHorizontalSlider extends StatefulWidget{
  String sliderTitle;
  List<Book> bookList;
  BookHorizontalSlider(this.sliderTitle, this.bookList, {Key key}) : super(key: key);


  @override
  _BookHorizontalSliderState createState() => _BookHorizontalSliderState(this.sliderTitle, this.bookList);
  
}

class _BookHorizontalSliderState extends State<BookHorizontalSlider>{
  String sliderTitle;
  List<Book> bookList;

  _BookHorizontalSliderState(this.sliderTitle, this.bookList);

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
      Book book = this.bookList[i];
      String title = book.getTitle(), author = book.getAuthor();
      userFavBooks.add(GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
          );
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
                      image: NetworkImage(book.getImageL()), fit: BoxFit.fill),
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
              Text(author.length > 30 ? author.substring(0,30) + "..." : author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: CurrentTheme.textColor2,
                  ))
            ],
          ),
        ),
      ));
    }
    return userFavBooks;
  }
}