import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  TabController _tabController;
  TextEditingController _commentController = TextEditingController(text: "");

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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatingActionButton(),
      backgroundColor: CurrentTheme.background,
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
                  width: double.infinity,
                  color: CurrentTheme.background,
                  child: _commentsTab()),
              /*TabBar(
                unselectedLabelColor: CurrentTheme.primaryColorVariant,
                labelColor: CurrentTheme.primaryColor,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(icon: Icon(Icons.comment)),
                  Tab(icon: Icon(Icons.book))
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(height: 100, width: 100,),
                    Container(height: 100, width: 100,),
                    */ /*_commentsTab(),
                    _readTab()*/ /*
                  ],
                ),
              ),*/
              Container(
                width: screenWidth,
                height: 100,
                decoration: BoxDecoration(
                  color: CurrentTheme.background,
                ),
              )
            ],
          )),
    );
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
              Fluttertoast.showToast(msg: "The book was added to favorites.");
            });
  }

  Widget _headerStack(double screenWidth) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
            height: 400.0,
            width: screenWidth,
            color: CurrentTheme.primaryColor),
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
        Positioned(top: 80, child: book.bookImage(width: 170)),
        Positioned(
            top: 30,
            left: 0,
            child: FlatButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white70,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ))
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
          book.synopsis == 'null' ? "Synopsis is no available." : book.synopsis,
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
          children: book.authorWidgetList(context),
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
    if (book.language != 'null') {
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

  /*Widget _tabSection() {
    return Column(children: [
      TabBar(
        unselectedLabelColor: CurrentTheme.primaryColorVariant,
        labelColor: CurrentTheme.primaryColor,
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
            Tab(icon: Icon(Icons.comment)),
            Tab(icon: Icon(Icons.book))
          ],
      ),
      Expanded(
        child: TabBarView(

          controller: _tabController,
          children: [_commentsTab(), _readTab()],
        ),
      ),
    ]);
  }*/

  Widget _commentsTab() {
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
        Center(child: Column(children: _comments()))
      ],
    );
  }

  List<Widget> _comments() {
    List<Widget> commentList = new List<Widget>();
    commentList.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: TextField(
            controller: _commentController,
            maxLines: null,
            maxLength: 250,
            cursorColor: CurrentTheme.textColor1,
            style: TextStyle(color: CurrentTheme.textColor3),
            decoration: InputDecoration(
                labelText: 'Comment this book',
                labelStyle: TextStyle(
                  color: CurrentTheme.primaryColorVariant,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: CurrentTheme.primaryColorVariant)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: CurrentTheme.primaryColorVariant)),
                helperStyle: TextStyle(color: CurrentTheme.textColor3)),
          ),
        ),
        RaisedButton(
          elevation: 0,
          color: Colors.transparent,
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: CurrentTheme.primaryColor),
              child: Icon(
                Icons.comment,
                color: Colors.white70,
              )),
          onPressed: () {
            if (_commentController.text != '') {
              BookComment comment = new BookComment(
                  MainUser.user.uid,
                  MainUser.user.name,
                  MainUser.user.nickname,
                  MainUser.user.imageUrl,
                  _commentController.text,
                  Timestamp.now());
              book.commentBook(comment);
              setState(() {});
            }
          },
        ),
      ],
    ));
    commentList.add(Divider(height: 40, thickness: 1,));
    var commentsWidgets = book.commentWidgetList();
    commentList.addAll(commentsWidgets);
    return commentList;
  }

  Widget _readTab() {
    return Container(
        width: double.infinity,
        height: 300,
        color: CurrentTheme.background,
        child: Text("Prueba"));
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
                Fluttertoast.showToast(
                    msg: "The book was removed from favorites.");
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

  void _showRateDialog() {
    double rate = 0.0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CurrentTheme.backgroundContrast,
          title: Text('Rate this book'),
          titleTextStyle: TextStyle(
              color: CurrentTheme.textColor3,
              fontWeight: FontWeight.w700,
              fontSize: 16),
          content: Center(
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                size: 10,
                color: CurrentTheme.primaryColor,
              ),
              onRatingUpdate: (rating) {
                rate = rating;
                print(rate);
                print(rating);
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: CurrentTheme.primaryColor,
              child: Text('SUBMIT'),
              onPressed: () {
                if (rate == 0.0 || rate == null) {
                  Fluttertoast.showToast(
                      msg: "Please rate the book to continue");
                } else {
                  Navigator.of(context).pop();
                  book.rate(rate);
                  Fluttertoast.showToast(msg: "Thanks for rating.");
                }
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
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Container(
                  width: 55,
                  height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CurrentTheme.primaryColor,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/amazon.png'))),
                ),
                onPressed: () async {
                  String url = book.buyURL['amazon'];
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    Fluttertoast.showToast(msg: "Link not available");
                  }
                  Navigator.of(context).pop();
                },
              ),
              book.buyURL['google'] == 'null'
                  ? null
                  : FlatButton(
                      child: Container(
                        width: 55,
                        height: 55,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CurrentTheme.primaryColor,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/google.png'))),
                      ),
                      onPressed: () async {
                        String url = book.buyURL['google'];
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          Fluttertoast.showToast(msg: "Link not available");
                        }
                        Navigator.of(context).pop();
                      },
                    ),
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
