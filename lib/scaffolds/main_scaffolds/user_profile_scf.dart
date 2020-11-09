import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/scaffolds/loading_scaffolds/profile_loading_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/book_horizontal_slider.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScaffold extends StatefulWidget {
  @override
  _UserProfileScaffoldState createState() => _UserProfileScaffoldState();
}

class _UserProfileScaffoldState extends State<UserProfileScaffold>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

/*class _UserProfileScaffoldState extends State<UserProfileScaffold>{
  MainUser _user = MainUser();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _user.setUser(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return _profileScaffold();
        } else {
          return ProfileLoadingScaffold();
        }
      },
    );
  }

  Scaffold _profileScaffold(){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          _profileHeader(context),
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: _descriptionBuilder(),
          ),
          SizedBox(height: 25),
          _userStatistics(),
          SizedBox(height: 20),
          _user.user.favBooks.length != 0? BookHorizontalSlider("Favorite books", _user.user.favBooks):
              _favBookWidget(),
          _favAuthorsWidget(),
          _favTagsWidget(),
          SizedBox(height: 30),
        ]),
      ),
    );
  }



  Widget _profileHeader(BuildContext context){
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
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _nameBuilder(),
                  SizedBox(height: 8),
                  _nickNameBuilder(),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 90,
          child: _profilePicBuilder(),
        ),
        Positioned(
          top:50, right: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () async {
              Navigator.pushNamed(context, '/settings');
              //G
              /*Book book = await Firestore().getBook("0002551675");
              print(book.imageURL);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
              );*/
            },
            child: Icon(Icons.settings,
                color: CurrentTheme.background,
                size:24.0),
          ),
        ),
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
                _user.user.statistics["followers"].toString() == null? "null" : _user.user.statistics["followers"].toString(),
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
                _user.user.statistics["following"].toString() == null? "null" : _user.user.statistics["following"].toString(),
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
                _user.user.statistics["books"].toString() == null? "null" : _user.user.statistics["books"].toString(),
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

  Widget _favBookWidget(){
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
              "Favorite books",
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
        Column(
          children: [
            Text("You don\'t have any favourite books yet",style: TextStyle(color: CurrentTheme.textColor3)),
            FlatButton(
                onPressed: (){

                },
                textColor: Colors.white,
                child: Container(
                    height: 30, width: 200,
                    padding: EdgeInsets.only(left:10,right: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: CurrentTheme.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Text("Discover new content!")))
          ],
        )
      ],
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
        _user.user.favAuthors.length != 0?
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
          ) : Column( children:
            [
              Text("You don\'t have any favourite authors yet",
              style: TextStyle(color: CurrentTheme.textColor3, fontSize: 16)),
              FlatButton(
                  onPressed: (){

                  },
                  textColor: Colors.white,
                  child: Container(
                    width: 200,
                      height: 30,
                      padding: EdgeInsets.only(left:10,right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CurrentTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
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
        _favTagsBuilder()
      ],
    );
  }

  List<Widget> _favAuthorsList() {
    List<Widget> userFavAuthors = new List<Widget>();
    for (MiniAuthor auth in _user.user.favAuthors) {
      userFavAuthors.add(auth.toWidget(context));
    }
    return userFavAuthors;
  }

  Widget _descriptionBuilder(){
    return Text(
        _user.user.description == null? "null" : _user.user.description,
        style: TextStyle(fontSize: 15, color: CurrentTheme.textColor1),
        textAlign: TextAlign.center);
  }

  Widget _nameBuilder(){
    return Text(
      _user.user.name == null? "null" : _user.user.name,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: CurrentTheme.textColor1
      ),
    );

  }

  Widget _nickNameBuilder() {
    return Text(
      _user.user.nickname == null? "null" : "@"+_user.user.nickname,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: CurrentTheme.textColor2),
    );
  }

  Widget _profilePicBuilder() {
    return new ProfileAvatar(profileImage: _user.user.userImageUrl);
  }

  Widget _favTagsBuilder() {
    return Container(
      alignment: Alignment.centerLeft,
      width: 300,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: CurrentTheme.backgroundContrast,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: CurrentTheme.shadow2, spreadRadius: 3, blurRadius: 5)
          ]),
      child: _user.user.tags.length != 0? Wrap(
        children: _favTagsToWidgets(_user.user.tags),
      ) : Column(
        children: [
          Text("You don\'t have any favourite tags yet"),
          FlatButton(
              onPressed: (){

              },
              textColor: Colors.white,
              child: Container(
                  height: 30, width: 200,
                  padding: EdgeInsets.only(left:10,right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: CurrentTheme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text("Discover new content!")))
        ],
      )
    );
  }

  List<Widget> _favTagsToWidgets(List<dynamic> userFavTagsList) {
    List<Widget> favTagsWidgets = new List<Widget>();
    for (int i = 0; i < userFavTagsList.length; i++) {
      favTagsWidgets.add(Container(
        height: 33,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: CurrentTheme.backgroundContrast,
            border: Border.all(color: CurrentTheme.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          userFavTagsList[i] == null? "null" : userFavTagsList[i],
          style: TextStyle(color: CurrentTheme.textColor2, fontSize: 13),
        ),
      ));
      favTagsWidgets.add(SizedBox(width: 10, height: 40));
    }
    return favTagsWidgets;
  }

}
*/