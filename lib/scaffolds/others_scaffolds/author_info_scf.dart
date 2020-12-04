import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/author.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/scaffolds/book_info_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthorInfoScaffold extends StatefulWidget {
  Author author;

  AuthorInfoScaffold(this.author, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthorInfoScaffoldState();
}

class _AuthorInfoScaffoldState extends State<AuthorInfoScaffold> {
  bool isFavorite;
  int followers;

  @override
  void initState() {
    isFavorite = MainUser.haveFavoriteAuthor(widget.author.name);
    followers = widget.author.followers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CurrentTheme.background,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CurrentTheme.primaryColor,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white70,
          ),
          onPressed: () async {
            MiniAuthor miniAuthor = new MiniAuthor(
              widget.author.name,
              widget.author.imageUrl,
              widget.author.bookCount,
              widget.author.followers);
            if (!isFavorite) {
              await MainUser.addAuthorToFavorites(miniAuthor);
            } else {
              await MainUser.removeAuthorToFavorites(miniAuthor);
            }

            Fluttertoast.showToast(
                msg: isFavorite
                    ? "The author was removed from favorites"
                    : "The author was added from favorites");

            setState(() {
              isFavorite = !isFavorite;
              if(isFavorite){
                followers = followers +1;
              } else {
                followers = followers <= 0? 0 : followers - 1;

              }
            });
          },
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 40, bottom: 40, left: 30, right: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
                gradient: CurrentTheme.primaryGradientColor),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white70),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: CurrentTheme.backgroundContrast,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(alignment: Alignment.center, children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      //fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/images/user_notFound.png"),
                                    ))),
                            widget.author.imageUrl != "null"? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white70),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          NetworkImage(widget.author.imageUrl),
                                    ))) : Container()
                          ]),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 130,
                            child: Text(
                              widget.author.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: CurrentTheme.textColor1,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    _authorStatistics()
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Text(widget.author.bio != "null" ? widget.author.bio : "",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: CurrentTheme.textColor3,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
            child: Text(
              "Books",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: CurrentTheme.textColor3,
              ),
            ),
          ),
          Container(
            width: 300,
            height: 1,
            color: CurrentTheme.primaryColor,
          ),
          SizedBox(height: 20),
          _authorBooks(),
                  SizedBox(height: 30)
        ])));
  }

  Widget _authorStatistics() {
    List<Widget> statistics = new List<Widget>();
    statistics.add(
        _statistic(Icons.book, widget.author.bookCount.toString() + " Books"));
    statistics.add(_statistic(Icons.person,
        FormatString.formatStatistic(followers) + " Followers"));
    if (widget.author.birthDate != "null" && widget.author.birthDate != null) {
      statistics.add(_statistic(Icons.cake, widget.author.birthDate));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: statistics,
    );
  }

  Widget _statistic(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          SizedBox(width: 10),
          Container(
            width: 90,
            child: Text(
              text,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  Widget _authorBooks() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 15,
        runSpacing: 15,
        children: _authorBooksList(),
      ),
    );
  }

  List<Widget> _authorBooksList() {
    List<Widget> booksList = new List<Widget>();
    List<MiniBook> list;
    if (widget.author.books == null) {
      list = [];
    } else {
      list = widget.author.books;
    }
    for (MiniBook miniBook in list) {
      booksList.add(GestureDetector(
          child: miniBook.miniBookImage(),
          onTap: () async {
            Book book = await Firestore().getBook(miniBook.isbn10);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookInfoScaffold(book: book)),
            );
          }));
    }
    return booksList;
  }
}
