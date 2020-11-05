import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/book_horizontal_slider.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScaffold extends StatefulWidget {
  @override
  _UserProfileScaffoldState createState() => _UserProfileScaffoldState();
}

class _UserProfileScaffoldState extends State<UserProfileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          _profileHeader(context),
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: Text(
                "This is my biography, here I write some stuff about me.",
                style: TextStyle(fontSize: 15, color: CurrentTheme.textColor1),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 20),
          _userStatistics(),
          SizedBox(height: 20),
          BookHorizontalSlider("Favorite books",_favBooksList()),
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
                  Text(
                    "David Butcher",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: CurrentTheme.textColor1
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "@DavidButcher",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: CurrentTheme.textColor2),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 90,
          child: new ProfileAvatar(),
        ),
        Positioned(
          top:55, right: 30,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/settings');
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
                "2.5k",
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
          SizedBox(width: 20),
          Container(
            height: 30,
            width: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: CurrentTheme.separatorColor),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "385",
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
          SizedBox(width: 20),
          Container(
            height: 30,
            width: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: CurrentTheme.separatorColor),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "137",
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
              height: 35,
              width: 45,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColorVariant,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
            Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Favorite Authors",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: CurrentTheme.textColor3),
                )),
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
        ),
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
              height: 35,
              width: 45,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColorVariant,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
            Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Favorite Tags",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: CurrentTheme.textColor3),
                )),
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
                BoxShadow(color: CurrentTheme.shadow2, spreadRadius: 3, blurRadius: 5)
              ]),
          child: Wrap(
            children: _favTagsList(),
          ),
        )
      ],
    );
  }

  _favBooksList() {
    List<Book> userFavBooks = new List<Book>();
    for(int i = 0; i<5; i++){
      userFavBooks.add(new Book("231","Prohibido creer en historias de amor","Javier Ruescas","2","3","4","https://espacio.fundaciontelefonica.com/wp-content/uploads/2018/03/portada-libro-ruescas-700x994-563x800.jpg"));
    }
    return userFavBooks;
  }

  _favAuthorsList() {
    var userFavAuthors = new List<Widget>();
    for (int i = 0; i < 7; i++) {
      userFavAuthors.add(Container(
        alignment: Alignment.center,
        width: 108,
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRvpVkmlEuN8y_vJ1eBZ8k7E62OGAUdEL3l9Q&usqp=CAU"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(height: 10),
            Text("Mark P. O. Morford",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: CurrentTheme.textColor2,
                ))
          ],
        ),
      ));
    }
    return userFavAuthors;
  } //TODO: Display user fav authors. Actual is a test example.

  _favTagsList() {
    var userFavTagsList = new List<Widget>();
    var testTags = [
      "Hola",
      "prueba123",
      "terror",
      "comedia",
      "Cálculo",
      "tag",
      "Tag largo de prueba",
      "poesía",
      "jaja",
      "otro Tag"
    ];
    for (int i = 0; i < 10; i++) {
      userFavTagsList.add(Container(
        height: 33,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: CurrentTheme.backgroundContrast,
            border: Border.all(color: CurrentTheme.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          testTags[i],
          style: TextStyle(color: CurrentTheme.textColor2, fontSize: 13),
        ),
      ));
      userFavTagsList.add(SizedBox(width: 10, height: 40));
    }
    return userFavTagsList;
  } //TODO: Display user fav Tags. Actual is a test example.
}
