import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
//import 'package:url_launcher/url_launcher.dart';

class BookInfoScaffold extends StatefulWidget {
  final Book book;
  BookInfoScaffold({Key key, @required this.book}) : super(key: key);
  _BookInfoScaffoldState createState() => _BookInfoScaffoldState(book);
}

class _BookInfoScaffoldState extends State<BookInfoScaffold>
    with TickerProviderStateMixin {
  Book book;
  bool isFavorite;

  Animation<double> _floatingButtonAnimation;
  AnimationController _floatingButtonAnimationController;

  _BookInfoScaffoldState(this.book);

  @override
  void initState() {
    isFavorite = MainUser.haveFavoriteBook(book.isbn["isbn_10"]);

    _floatingButtonAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
        curve: Curves.easeInOut, parent: _floatingButtonAnimationController);
    _floatingButtonAnimation =
        Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        color: CurrentTheme.primaryColor,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: _floatingActionButton(),
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
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                      decoration: BoxDecoration(
                        color: CurrentTheme.background,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _firstInfo(),
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
                      child: _commentSection()),
                  Container(
                    width: screenWidth,
                    height: 100,
                    decoration: BoxDecoration(
                      color: CurrentTheme.background,
                    ),
                  )
                ],
              )),
        ));
  }

  FloatingActionBubble _floatingActionButton() {
    return FloatingActionBubble(
      iconData: Icons.more_vert,
      iconColor: Colors.white70,
      backGroundColor: CurrentTheme.primaryColor,
      animation: _floatingButtonAnimation,
      onPress: () => _floatingButtonAnimationController.isCompleted
          ? _floatingButtonAnimationController.reverse()
          : _floatingButtonAnimationController.forward(),
      items: <Bubble>[
        Bubble(
            title: "Get this book",
            iconColor: Colors.white70,
            icon: Icons.shop_two,
            bubbleColor: CurrentTheme.primaryColor,
            titleStyle: TextStyle(color: Colors.white70, fontSize: 16),
            onPress: () {
              _showBuyScaffold();
              _floatingButtonAnimationController.reverse();
            }),
        Bubble(
            title: "Read",
            iconColor: Colors.white70,
            icon: Icons.book,
            bubbleColor: CurrentTheme.primaryColor,
            titleStyle: TextStyle(color: Colors.white70, fontSize: 16),
            onPress: () {
              print("Read scaffold");
              _floatingButtonAnimationController.reverse();
            }),
        Bubble(
            title: "Rate this book",
            iconColor: Colors.white70,
            icon: Icons.star,
            bubbleColor: CurrentTheme.primaryColor,
            titleStyle: TextStyle(color: Colors.white70, fontSize: 16),
            onPress: () {
              _showRateDialog();
              print("Rate dialog");
              _floatingButtonAnimationController.reverse();
            }),
        Bubble(
            title: "Add to list",
            iconColor: Colors.white70,
            icon: Icons.add,
            bubbleColor: CurrentTheme.primaryColor,
            titleStyle: TextStyle(color: Colors.white70, fontSize: 16),
            onPress: () {
              _showAddToListDialog();
              print("add to list");
              _floatingButtonAnimationController.reverse();
            }),
        _favBubble()
      ],
    );
  }

  Bubble _favBubble() {
    return this.isFavorite
        ? Bubble(
            title: "Remove from favorites",
            iconColor: Colors.white70,
            icon: Icons.favorite,
            bubbleColor: CurrentTheme.primaryColor,
            titleStyle: TextStyle(color: Colors.white70, fontSize: 16),
            onPress: () {
              _showRemoveFromFavsDialog();
              _floatingButtonAnimationController.reverse();
            })
        : Bubble(
            title: "Add to favorites",
            iconColor: Colors.white70,
            icon: Icons.favorite_border,
            bubbleColor: CurrentTheme.primaryColor,
            titleStyle: TextStyle(color: Colors.white70, fontSize: 16),
            onPress: () {
              book.addToFavorites();
              setState(() {
                this.isFavorite = true;
              });
              _floatingButtonAnimationController.reverse();
            });
  }

  Widget _headerStack(double screenWidth) {
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
                    topLeft: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      color: CurrentTheme.shadow1,
                      spreadRadius: 5,
                      blurRadius: 30,
                      offset: Offset(0, 0))
                ]),
          ),
        ),
        Positioned(top: 80, child: book.bookImage(width: 170))
      ],
    );
  }

  Widget _firstInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          book.title == 'null' ? "Not found" : book.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: CurrentTheme.textColor1,
              fontSize: 25,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 15),
        Text(book.publisher == 'null' ? "Not found" : book.publisher,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CurrentTheme.textColor3,
                fontWeight: FontWeight.w400,
                fontSize: 20)),
        SizedBox(height: 10),
        book.year.toString() == '0' || book.year.toString() == 'null'
            ? null
            : Text(book.year.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CurrentTheme.textColor3,
                    fontWeight: FontWeight.w100,
                    fontSize: 20)),
        SizedBox(height: 40),
        _firstStatistics(),
        SizedBox(height: 40),
        Text(
          book.synopsis == 'null' || book.synopsis.length == 0
              ? "Synopsis is no available."
              : book.synopsis,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: CurrentTheme.textColor1,
              fontWeight: FontWeight.w200,
              fontSize: 14.5),
        ),
      ],
    );
  }

  Widget _firstStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: book.authorWidgetList(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 25),
          child: Container(
            height: 50,
            width: 1,
            color: CurrentTheme.separatorColor,
          ),
        ),
        Column(
          children: [
            Text(
              book.rating.toStringAsFixed(1),
              style: TextStyle(color: CurrentTheme.textColor3, fontSize: 30),
            ),
            book.ratingStars(book.rating)
          ],
        )
      ],
    );
  }

  Widget _secondStatistics() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _bookStatistics(),
      ),
    );
  }

  List<Widget> _bookStatistics() {
    List<Widget> statistics = new List<Widget>();
    statistics.add(
      Column(
        children: [
          Icon(Icons.visibility, size: 30, color: CurrentTheme.textColor1),
          SizedBox(height: 5),
          Text(
            FormatString.formatStatistic(book.views) + ' views',
            style: TextStyle(color: CurrentTheme.textColor3),
          )
        ],
      ),
    );
    if (book.pages.toString() != 'null' && book.pages.toString() != '0') {
      statistics.add(
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 30,
            width: 1,
            color: CurrentTheme.separatorColor,
          ),
        ),
      );
      statistics.add(
        Column(
          children: [
            Icon(Icons.chrome_reader_mode,
                size: 30, color: CurrentTheme.textColor1),
            SizedBox(height: 5),
            Text(book.pages.toString() + ' pages',
                style: TextStyle(color: CurrentTheme.textColor3))
          ],
        ),
      );
    }
    if (book.language != 'null' && book.language.length != 0) {
      statistics.add(
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 30,
            width: 1,
            color: CurrentTheme.separatorColor,
          ),
        ),
      );
      statistics.add(
        Column(
          children: [
            Icon(Icons.language, size: 30, color: CurrentTheme.textColor1),
            SizedBox(height: 5),
            Text(book.language,
                style: TextStyle(color: CurrentTheme.textColor3))
          ],
        ),
      );
    }
    return statistics;
  }

  Widget _finalInfo() {
    return Table(
      columnWidths: {1: FractionColumnWidth(.6)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        book.isbn["isbn_10"] != 'null'
            ? TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30),
                  child: Text(
                    "ISBN-10:",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: CurrentTheme.textColor3),
                  ),
                ),
                Text(book.isbn["isbn_10"],
                    style: TextStyle(color: CurrentTheme.textColor3))
              ])
            : null,
        book.isbn["isbn_13"] != 'null'
            ? TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30),
                  child: Text("ISBN-13:",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: CurrentTheme.textColor3)),
                ),
                Text(book.isbn["isbn_13"],
                    style: TextStyle(color: CurrentTheme.textColor3))
              ])
            : null,
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30),
            child: Text("Categories:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: CurrentTheme.textColor3)),
          ),
          Container(
            child: book.tags.length == 0
                ? Text("This book has not categories.",
                    style: TextStyle(color: CurrentTheme.textColor3))
                : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: book.tagWidgetList(),
                  ),
          )
        ]),
      ],
    );
  }

  Widget _commentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
            SizedBox(width: 15),
            Text(
              "Comments",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: CurrentTheme.textColor3),
            )
          ]),
        ),
        SizedBox(height: 15),
        Center(
          child: Column(
              children: book.comments.length != 0
                  ? book.commentWidgetList()
                  : [
                      Text("No comments yet",
                          style: TextStyle(color: CurrentTheme.textColor3)),
                      FlatButton(
                          onPressed: () {
                            _showCommentDialog();
                          },
                          textColor: Colors.white,
                          child: Container(
                              height: 30,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: CurrentTheme.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text("Be the first comment!")))
                    ]),
        )
      ],
    );
  }

  void _showRemoveFromFavsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CurrentTheme.backgroundContrast,
          title: Text('Remove from favorites'),
          titleTextStyle: TextStyle(
              color: CurrentTheme.textColor3,
              fontWeight: FontWeight.w700,
              fontSize: 16),
          content: Text(
            'Would you like remove this book form your favorites list?',
            style: TextStyle(
                color: CurrentTheme.textColor3,
                fontWeight: FontWeight.w300,
                fontSize: 14.5),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: CurrentTheme.primaryColor,
              child: Text('YES'),
              onPressed: () {
                book.removeFromFavorites();
                Navigator.of(context).pop();
                this.setState(() {
                  this.isFavorite = false;
                });
              },
            ),
            FlatButton(
              textColor: CurrentTheme.primaryColor,
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showRateDialog() {}

  void _showCommentDialog() {}

  void _showAddToListDialog() {}

  void _showBuyScaffold() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CurrentTheme.backgroundContrast,
          title: Text('Get this book'),
          titleTextStyle: TextStyle(
              color: CurrentTheme.textColor3,
              fontWeight: FontWeight.w700,
              fontSize: 16),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 220,
                padding: EdgeInsets.only(top:15,bottom: 15, right: 30,left: 30),
                child: Text("Amazon link",
                  style: TextStyle(
                      color: CurrentTheme.textColor3,
                      fontSize: 16),
                ),
                decoration: BoxDecoration(
                  color: CurrentTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 220,
                padding: EdgeInsets.only(top:15,bottom: 15, right: 30,left: 30),
                child: Text("Google link",
                  style: TextStyle(
                      color: CurrentTheme.textColor3,
                      fontSize: 16),
                ),
                decoration: BoxDecoration(
                  color: CurrentTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Go back',
                style:
                    TextStyle(color: CurrentTheme.primaryColor, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
