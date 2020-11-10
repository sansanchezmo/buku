import 'package:buku/main_objects/book.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
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
        floatingActionButton:
            FloatingActionButton(
              backgroundColor: CurrentTheme.primaryColor,
              onPressed: () {  },
              child: Icon(Icons.more_vert)
            ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _headerStack(screenWidth),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
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
                          fontSize: 25,
                          fontWeight: FontWeight.w800
                        ),),
                      SizedBox(height: 15),
                      Text(
                        book.publisher,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        )),
                      SizedBox(height: 10),
                      Text(
                          book.year,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 20
                          )),

                      SizedBox(height: 40),
                      _firstStatistics(),
                      SizedBox(height: 40),
                      Text(
                        book.synopsis == null || book.synopsis.length == 0? "Synopsis is no available." : book.synopsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14.5
                        ),),
                      SizedBox(height: 50),
                      _secondStatistics(),
                      SizedBox(height: 40),
                      _finalInfo(),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
              Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: CurrentTheme.background,
                  ),
                  child: _commentSection())
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
          height: 400.0,
          width: screenWidth,
        ),
        Positioned(
          top: 230,
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
            top: 80,
            child: book.bookImage(width: 170)
        )
      ],

    );
  }

  Widget _firstStatistics(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: book.authorWidgetList(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 25),
          child: Container(
            height: 50,
            width: 1,
            color: CurrentTheme.separatorColor,
          ),
        ),
        Column(
          children: [
            Text(book.rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 30
            ),),
            book.ratingStars(book.rating)
          ],
        )
      ],
    );
  }

  Widget _secondStatistics(){
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(Icons.visibility, size: 30),
                SizedBox(height: 5),
                Text(FormatString.formatStatistic(book.views) + ' views')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 30,
                width: 1,
                color: CurrentTheme.separatorColor,
              ),
            ),
            Column(
              children: [
                Icon(Icons.chrome_reader_mode, size: 30),
                SizedBox(height: 5),
                Text(book.pages.toString() + ' pages')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 30,
                width: 1,
                color: CurrentTheme.separatorColor,
              ),
            ),
            Column(
              children: [
                Icon(Icons.language, size: 30),
                SizedBox(height: 5),
                Text(book.language)
              ],
            ),
          ],
        ),
      );
  }

  Widget _finalInfo(){
      return Table(
        columnWidths: {1:FractionColumnWidth(.7)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          book.isbn["isbn_10"] != null?
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top:10,bottom: 10,left: 30),
                child: Text("ISBN-10:", style: TextStyle(fontWeight: FontWeight.w700),),
              ),
              Text(book.isbn["isbn_10"])
            ]
          ) : null,

          book.isbn["isbn_13"] != null?
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.only(top:10,bottom: 10,left: 30),
              child: Text("ISBN-13:", style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            Text(book.isbn["isbn_13"])
          ]
          ) : null,

          TableRow(children: [
            Padding(
              padding: const EdgeInsets.only(top:10,bottom: 10,left: 30),
              child: Text(book.tags.length > 1 ? "Categories:":"Category:",
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            Container(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: book.tagWidgetList(),
              ),
            )
          ]),

        ],
      );
  }

  Widget _commentSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                width: 40, height: 30,
                decoration: BoxDecoration(
                  color: CurrentTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                ),
              ),
              SizedBox(width: 15),
              Text("Comments",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),)
            ]
          ),
        ),
        SizedBox(height: 15),

        Center(
          child: Column(
            children: book.comments.length != 0? book.commentWidgetList() :
                [
                  Text("No comments yet"),
                  FlatButton(
                    onPressed: (){ _showCommentDialog();},
                      textColor: Colors.white,
                      child: Container(
                          height: 30, width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: CurrentTheme.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text("Be the first comment!")))
                ]
          ),
        )

      ],
    );
  }

  _showFavBookDialog() {

  }

  _showCommentDialog(){

  }
}
