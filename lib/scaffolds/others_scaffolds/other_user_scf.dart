import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/main_objects/user.dart';
import 'package:buku/scaffolds/others_scaffolds/users_list_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/book_horizontal_slider.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class OtherUserScaffold extends StatefulWidget {
  User _user;

  OtherUserScaffold(this._user, {Key key}) : super(key: key);

  @override
  _OtherUserScaffoldState createState() => _OtherUserScaffoldState(this._user);
}

class _OtherUserScaffoldState extends State<OtherUserScaffold> {
  User _user;
  bool _isFollowed;

  _OtherUserScaffoldState(this._user) {
    _isFollowed = MainUser.haveFollower(_user.uid);
  }

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
                //color: CurrentTheme.primaryColor,
                gradient: CurrentTheme.primaryGradientColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            _userIdentificators()
          ],
        ),
        Positioned(
          top: 90,
          child: ProfileAvatar(profileImage: this._user.imageUrl),
        ),
        this._user.uid == MainUser.uid
            ? Container()
            : Positioned(
                bottom: 60,
                child: _isFollowed
                    ? Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CurrentTheme.primaryColor),
                        child: IconButton(
                            onPressed: () {
                              MiniUser miniUser = new MiniUser(
                                  this._user.uid,
                                  this._user.name,
                                  this._user.nickname,
                                  this._user.imageUrl);
                              MainUser.unfollow(miniUser);
                              setState(() {
                                this._isFollowed = !_isFollowed;
                              });
                            },
                            icon: Icon(
                              Icons.person_remove,
                              color: Colors.white70,
                              size: 15,
                            )),
                      )
                    : Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CurrentTheme.backgroundContrast,
                            border:
                                Border.all(color: CurrentTheme.primaryColor)),
                        child: IconButton(
                            onPressed: () {
                              MiniUser miniUser = new MiniUser(
                                  this._user.uid,
                                  this._user.name,
                                  this._user.nickname,
                                  this._user.imageUrl);
                              MainUser.follow(miniUser);
                              setState(() {
                                this._isFollowed = !_isFollowed;
                              });
                            },
                            icon: Icon(Icons.person_add,
                                color: CurrentTheme.primaryColor, size: 15)),
                      )),
        Positioned(
          top: 50,
          left: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white70, size: 24.0),
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
              this._user.description == null ? "null" : this._user.description,
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
        this._user.favBooks == [] ||
                this._user.favBooks == null ||
                this._user.favBooks.length == 0
            ? Container()
            : BookHorizontalSlider(
                "Favorite books", this._user.favBooks, Container()),
        this._user.favAuthors == [] ||
                this._user.favAuthors == null ||
                this._user.favAuthors.length == 0
            ? Container()
            : _favAuthorsWidget(),
        this._user.tags == [] ||
                this._user.tags == null ||
                this._user.tags.length == 0
            ? Container()
            : _favTagsWidget(),
      ],
    );
  }

  Widget _userStatistics() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UsersListScaffold(this._user.followers, "Followers")),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this._user.statistics["followers"].toString() == null
                      ? "null"
                      : this._user.statistics["followers"].toString(),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UsersListScaffold(this._user.following, "Following")),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this._user.statistics["following"].toString() == null
                      ? "null"
                      : this._user.statistics["following"].toString(),
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
                this._user.statistics["books"].toString() == null
                    ? "null"
                    : this._user.statistics["books"].toString(),
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
        Container(
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
            child: Wrap(
              children: this._user.tagsToWidget(),
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
            this._user.name == null ? "null" : this._user.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: CurrentTheme.textColor1),
          ),
          SizedBox(height: 8),
          Text(
            this._user.nickname == null ? "null" : "@" + this._user.nickname,
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
    for (MiniAuthor auth in this._user.favAuthors) {
      userFavAuthors.add(Padding(
        padding: const EdgeInsets.only(left: 12.5, right: 12.5),
        child: auth.toWidget(context),
      ));
    }
    return userFavAuthors;
  }
}
