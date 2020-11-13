import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/scaffolds/book_info_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/book_horizontal_slider.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Methods hierarchy:
/// Build -> Scaffold
///
///       +_profileHeaderSection -> It contains the upper items.
///             +_userIdentificators -> It contains the user name and nickname.
///             +(Widget) ProfileAvatar -> Instance of ProfileAvatar class.
///
///       +_userInfoSection -> It contains the description and the user statistics.
///             +_userStatistics -> It shows a Row with the statistics.
///
///       +_userFavsSection ->
///             +(Widget) BookHorizontalSlider -> Shows fav books.
///             +_favAuthorsWidget() -> Shows fav authors.
///                     _favAuthorsList -> Returns a list of miniBook widgets.
///             +_favTagsWidget() -> Shows the user fav tags.
///

class UserProfileScaffold extends StatefulWidget {
  @override
  MainUserProfileScaffoldState createState() => MainUserProfileScaffoldState();
}

class MainUserProfileScaffoldState extends State<UserProfileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          _profileHeaderSection(context),
          _userInfoSection(),
          _userFavsSection(),
          SizedBox(height: 30)
        ]),
      ),
    );
  }

  Widget _profileHeaderSection(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: [
        Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: CurrentTheme.shadow1,
                        spreadRadius: 5,
                        blurRadius: 30)
                  ]),
            ),
            SizedBox(
              height: 75,
            ),
            _userIdentificators()
          ],
        ),
        Positioned(
          top: 90,
          child: ProfileAvatar(profileImage: MainUser.user.imageUrl),
        ),
        Positioned(
          top: 50,
          right: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/settings');
              /*
              Book book = await Firestore().getBook("0001046438");
              print(book.imageURL);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookInfoScaffold(book: book)),
              );

               */
            },
            child: Icon(Icons.settings,
                color: CurrentTheme.background, size: 24.0),
          ),
        ),
      ],
    );
  }

  Widget _userInfoSection() {
    return Column(
      children: [
        SizedBox(height: 25),
        Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: Text(
              MainUser.user.description == null
                  ? "null"
                  : MainUser.user.description,
              style: TextStyle(fontSize: 15, color: CurrentTheme.textColor1),
              textAlign: TextAlign.center),
        ),
        SizedBox(height: 25),
        _userStatistics(),
      ],
    );
  }

  Widget _userFavsSection() {
    return Column(
      children: [
        BookHorizontalSlider(
            "Favorite books",
            MainUser.user.favBooks,
            Column(
              children: [
                Text("You don\'t have any favourite books yet",
                    style: TextStyle(color: CurrentTheme.textColor3)),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/menu');
                    },
                    textColor: Colors.white,
                    child: Container(
                        height: 30,
                        width: 200,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: CurrentTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text("Discover new content!")))
              ],
            )),
        _favAuthorsWidget(),
        _favTagsWidget(),
      ],
    );
  }

  Widget _userStatistics() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                MainUser.user.statistics["followers"].toString() == null
                    ? "null"
                    : MainUser.user.statistics["followers"].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: CurrentTheme.textColor1),
              ),
              Text(
                "Followers",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: CurrentTheme.textColor2),
              )
            ],
          ),
          SizedBox(width: 25),
          Container(
            height: 30,
            width: 1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: CurrentTheme.separatorColor),
          ),
          SizedBox(width: 25),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                MainUser.user.statistics["following"].toString() == null
                    ? "null"
                    : MainUser.user.statistics["following"].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: CurrentTheme.textColor1),
              ),
              Text(
                "Following",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: CurrentTheme.textColor2),
              )
            ],
          ),
          SizedBox(width: 25),
          Container(
            height: 30,
            width: 1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: CurrentTheme.separatorColor),
          ),
          SizedBox(width: 25),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                MainUser.user.statistics["books"].toString() == null
                    ? "null"
                    : MainUser.user.statistics["books"].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: CurrentTheme.textColor1),
              ),
              Text(
                "Books",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: CurrentTheme.textColor2),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _favAuthorsWidget() {
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
              "Favorite authors",
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
        MainUser.user.favAuthors.length != 0
            ? Container(
                height: 130,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: _favAuthorsList(),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              )
            : Column(children: [
                Text("You don\'t have any favourite authors yet",
                    style: TextStyle(
                        color: CurrentTheme.textColor3, fontSize: 16)),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/menu');
                    },
                    textColor: Colors.white,
                    child: Container(
                        width: 200,
                        height: 30,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: CurrentTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text("Discover new content!")))
              ])
      ],
    );
  }

  Widget _favTagsWidget() {
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
              "Favorite tags",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: CurrentTheme.textColor3),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            alignment: Alignment.centerLeft,
            width: 300,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: CurrentTheme.backgroundContrast,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: CurrentTheme.shadow2,
                      spreadRadius: 3,
                      blurRadius: 5)
                ]),
            child: MainUser.user.tags.length != 0
                ? Wrap(
                    children: MainUser.user.tagsToWidget(),
                  )
                : Column(
                    children: [
                      Text("You don\'t have any favourite tags yet"),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed('/menu');
                          },
                          textColor: Colors.white,
                          child: Container(
                              height: 30,
                              width: 200,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: CurrentTheme.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text("Discover new content!")))
                    ],
                  ))
      ],
    );
  }

  Widget _userIdentificators() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            MainUser.user.name == null ? "null" : MainUser.user.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: CurrentTheme.textColor1),
          ),
          SizedBox(height: 8),
          Text(
            MainUser.user.nickname == null
                ? "null"
                : "@" + MainUser.user.nickname,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: CurrentTheme.textColor2),
          ),
        ],
      ),
    );
  }

  List<Widget> _favAuthorsList() {
    List<Widget> userFavAuthors = new List<Widget>();
    for (MiniAuthor auth in MainUser.user.favAuthors) {
      userFavAuthors.add(Padding(
        padding: const EdgeInsets.only(left: 12.5, right: 12.5),
        child: auth.toWidget(context),
      ));
    }
    return userFavAuthors;
  }
}
