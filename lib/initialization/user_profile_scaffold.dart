import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainObjects/book.dart';

class UserProfileScaffold extends StatefulWidget {
  @override
  _UserProfileScaffold createState() => _UserProfileScaffold();
}

class _UserProfileScaffold extends State<UserProfileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: [
              Column(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
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
                              color: Colors.black87),
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
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 90,
                child: _profileAvatar(),
              ),
            ],
          ),
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            child: Text(
                "This is my biography, here I write some stuff about me.",
                style: TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 20),
          _userStatistics(),
          SizedBox(height: 20),
          _favBooksWidget(),
          _favAuthorsWidget(),
          _favTagsWidget(),
          SizedBox(height: 30),
        ]),
      ),
    );
  }

  _profileAvatar() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 0.5),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  "https://images.megapixl.com/4707/47075236.jpg"))),
    );
  }

  _userStatistics() {
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
                    color: Colors.black87),
              ),
              Text(
                "Followers",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black54),
              )
            ],
          ),
          SizedBox(width: 20),
          Container(
            height: 30,
            width: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(38, 38, 38, 0.1)),
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
                    color: Colors.black87),
              ),
              Text(
                "Following",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black54),
              )
            ],
          ),
          SizedBox(width: 20),
          Container(
            height: 30,
            width: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(38, 38, 38, 0.1)),
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
                    color: Colors.black87),
              ),
              Text(
                "Books",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black54),
              )
            ],
          )
        ],
      ),
    );
  }

  _favBooksWidget() {
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
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
            Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Favorite books",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromRGBO(38, 38, 38, 0.8)),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 225,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: _favBooksList(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _favAuthorsWidget() {
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
                  color: Colors.orange,
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
                      color: Color.fromRGBO(38, 38, 38, 0.8)),
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

  _favTagsWidget() {
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
                  color: Colors.orange,
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
                      color: Color.fromRGBO(38, 38, 38, 0.8)),
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
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 3, blurRadius: 5)
              ]),
          child: Wrap(
            children: _favTagsList(),
          ),
        )
      ],
    );
  }

  _favBooksList() {
    var userFavBooks = List<Widget>();
    for (int i = 0; i < 5; i++) {
      Book book = new Book(
          "0002005018",
          "Classical Mythology",
          "Mark P. O. Morford",
          "2002",
          "Oxford University Press",
          "Building on the bestselling tradition of previous editions, Classical Mythology, Tenth Edition, is the most comprehensive survey of classical mythology available--and the first full-color textbook of its kind. Featuring the authors' clear and extensive translations of original sources, it brings to life the myths and legends of Greece and Rome in a lucid and engaging style. The text contains a wide variety of faithfully translated passages from Greek and Latin sources, including Homer, Hesiod, all the Homeric Hymns, Pindar, Aeschylus, Sophocles, Euripides, Herodotus, Plato, Lucian, Lucretius, Vergil, Ovid, and Seneca. ",
          "http://images.amazon.com/images/P/0195153448.01.THUMBZZZ.jpg",
          "link2",
          "http://images.amazon.com/images/P/0195153448.01.LZZZZZZZ.jpg");
      userFavBooks.add(Container(
        alignment: Alignment.center,
        width: 150,
        padding: EdgeInsets.only(right: 15, left: 15),
        child: Column(
          children: [
            Container(
              height: 130,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(book.getImageL()), fit: BoxFit.fill),
                /*boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 5, blurRadius: 5)
                  ]*/
              ),
            ),
            SizedBox(height: 10),
            Text(book.getTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black54,
                )),
            SizedBox(height: 5),
            Text(book.getAuthor(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ))
          ],
        ),
      ));
    }
    return userFavBooks;
  } //TODO: Display user fav books. Actual is a test example.

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
                  color: Colors.black54,
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
        height: 30,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          testTags[i],
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ));
      userFavTagsList.add(SizedBox(width: 10, height: 40));
    }
    return userFavTagsList;
  } //TODO: Display user fav Tags. Actual is a test example.
}
