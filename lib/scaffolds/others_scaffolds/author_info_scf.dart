import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/author.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/scaffolds/book_info_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorInfoScaffold extends StatefulWidget {
  Author author;

  AuthorInfoScaffold(this.author, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthorInfoScaffoldState();
}

class _AuthorInfoScaffoldState extends State<AuthorInfoScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CurrentTheme.background,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
                gradient: CurrentTheme.primaryGradientColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: CurrentTheme.backgroundContrast),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/user_notFound.png"),
                                ))),
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(widget.author.imageUrl),
                                )))
                      ]),
                      SizedBox(height: 18,),
                      Container(
                        width: 130,
                        child: Text(widget.author.name),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                _authorStatistics()
              ],
            ),
          ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Text(widget.author.bio != "null"? widget.author.bio : "",
                style: TextStyle(
                  fontSize: 16,
                  color: CurrentTheme.textColor3,
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(right: 20,left: 20,top: 10),
                child: Text("Books",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CurrentTheme.textColor3,
                ),),
              ),
              Container(
                width: double.infinity,
                height: 1,
                padding: EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 30),
                color: CurrentTheme.primaryColor,
              ),
              _authorBooks()
        ])));
  }

  Widget _authorStatistics() {
    List<Widget> statistics = new List<Widget>(3);
    statistics.add(_statistic(Icons.book, widget.author.bookCount.toString() + " Books"));
    statistics.add(_statistic(Icons.person, FormatString.formatStatistic(widget.author.followers) + " Followers"));
    if(widget.author.birthDate != "null" && widget.author.birthDate != null){
      statistics.add(_statistic(Icons.cake, widget.author.birthDate));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: statistics,
    );
  }

  Widget _statistic(IconData icon, String text){
    return Row(
      children: [
        Icon(
            icon,
            color: Colors.white70,
            size: 10),
        SizedBox(width: 10),
        Text(text,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 15
        ),)
      ],
    );
  }

  Widget _authorBooks(){
    return Wrap(
      direction: Axis.vertical,
      spacing: 15,
      children: _authorBooksList(),
    );
  }

  List<Widget> _authorBooksList(){
    List<Widget> booksList = new List<Widget>();
    List<MiniBook> list;
    if (widget.author.books == null){
      list = [];
    } else {
      list = widget.author.books;
    }
    for(MiniBook miniBook in list){
      booksList.add(
        GestureDetector(child: miniBook.miniBookImage(),
        onTap: () async {
          Book book = await Firestore().getBook(miniBook.isbn10);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
          );
        })
      );
    }
    return booksList;
  }
}
