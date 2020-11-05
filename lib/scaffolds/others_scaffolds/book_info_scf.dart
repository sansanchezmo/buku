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
    final rating = book.getRating();
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
              Stack(
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
                    child: _bookImage()
                  )
                ],

              ),
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
                      book.getTitle(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 15),
                    Text(
                      book.getAuthor(),
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
                    _bookStatistics(rating),
                    SizedBox(height: 30),
                    Text(book.getSynopsis(),
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
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            child: Text("Info",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),),),
                          SizedBox(height: 10),
                          Container(
                            child: Column(
                              children: _bookInfo(),
                            ),
                          )
                        ],
                      ),
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




  _bookImage(){
    return Container(
          height: 280,
          width: 175,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(book.getImageL()),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: CurrentTheme.shadow1,
                    spreadRadius: 5,
                    blurRadius: 20
                )]
          )
      );
  }

  _bookStatistics(double rating){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: _ratingStars(rating)
              ),
              Text(rating.toString())
            ],
          ),
          SizedBox(width: 20),
          Container(
            height: 20,
            width: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color:CurrentTheme.textColor2,
            ),
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Icon(Icons.visibility,
              color: CurrentTheme.primaryColor,
                  size:20.0),
              Text("25.3K views")
            ],
          )
        ]);
  }

  _bookInfo(){
    return [
      /*Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: "Genre: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "Terror")
            ])),
      ),
      SizedBox(height: 10),*/
      Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: "Year: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: book.getYear())
            ])),
      ),
      SizedBox(height: 10),
      Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: "Publisher: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: book.getPublisher())
            ])),
      ),
      SizedBox(height: 10),
      /*Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: "Country: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "country")
            ])),
      ),
      SizedBox(height: 10),*/
      /*Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: "Pages: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "240")
            ])),
      ),
      SizedBox(height: 10),*/
      Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: "ISBN: ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: book.getISBN())
            ])),
      )
    ];
  }

  _ratingStars(double rating){
    double rat = rating;
    var ratingStars = List<Widget>(5);
    for(int i = 0; i<5;i++){
      if(rat>=1){
        ratingStars[i] = Icon(Icons.star,
                          color: CurrentTheme.primaryColor,
                          size:15.0);
      } else if (rat>0){
        ratingStars[i] = Icon(Icons.star_half,
                          color: CurrentTheme.primaryColor,
                          size:15.0);
        rat = 0;
      } else if (rat<=0){
        ratingStars[i] = Icon(Icons.star_border,
                          color: CurrentTheme.primaryColor,
                          size:15.0);
      }
      rat--;
    }
    return ratingStars;
  }
}
