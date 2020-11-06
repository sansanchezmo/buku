import 'package:buku/main_objects/book.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BookInfoScaffold extends StatefulWidget {
  final Book book;
  BookInfoScaffold({Key key, @required this.book}) : super(key: key);
  _BookInfoScaffoldState createState() => _BookInfoScaffoldState(book);
}

class _BookInfoScaffoldState extends State<BookInfoScaffold> {
 Book book;

 _BookInfoScaffoldState(this.book);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: CurrentTheme.primaryColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _headerStack(screenWidth),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 30
                ),
                decoration: BoxDecoration(
                  color: CurrentTheme.background,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 15),
                    Text(
                      //book.authors,
                      "Aún no jaja",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20
                      )),
                    SizedBox(height: 10),

                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit:BoxFit.fill,
                          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjNUOgjEhHpfUqnVk-Tp2uN1AhrrzXhwdX9A&usqp=CAU")
                        )
                      )
                    ),

                    SizedBox(height: 30),

                    book.bookStatistics(),

                    SizedBox(height: 30),

                    Text(
                      book.synopsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16
                      ),),

                    SizedBox(height: 30),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth-100,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: CurrentTheme.background,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow:  [
                          BoxShadow(
                              color: CurrentTheme.shadow2,
                              spreadRadius: 5,
                              blurRadius: 10
                          )]
                      ),
                      child: book.bookInfo()
                    )
                  ],
                ),
              )
            ],
          )
        ),
      )
    );
  }

  Widget _headerStack(double screenWidth){
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        SizedBox(
          height: 430.0,
          width: screenWidth,
        ),
        Positioned(
          top: 250,
          left: 0,
          child: Container(
            height: 500,
            width: screenWidth,
            decoration: BoxDecoration(
                color: CurrentTheme.background,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)
                ),
                boxShadow: [
                  BoxShadow(
                      color: CurrentTheme.shadow1,
                      spreadRadius: 5,
                      blurRadius: 30,
                      offset: Offset(0,0)
                  )]
            ),

          ),
        ),
        Positioned(
            top: 100,
            child: book.bookImage()
        )
      ],

    );
  }


}
