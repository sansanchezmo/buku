import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/main_objects/publication.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForumScaffold extends StatefulWidget {
  @override
  _ForumScaffoldState createState() => _ForumScaffoldState();
}

class _ForumScaffoldState extends State<ForumScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 165,
            decoration: BoxDecoration(
                gradient: CurrentTheme.primaryGradientColorInverted,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40))),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                children: [
                  Container(
                    width: 55,
                    height: 60,
                    child: Image(
                      image: AssetImage("assets/images/bukusymbol.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 60,
                    height: 20,
                    child: Image(
                      image: AssetImage("assets/images/bukuword.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(child: SizedBox(height: 10)),
                  IconButton(
                      icon: Icon(Icons.person_search,
                      color: Colors.white70,
                      size: 25),
                      onPressed: () {
                        //TODO: search user scaffold
                      })
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(children: _publicationList()),
        ],
      )),
    );
  }

  List<Widget> _publicationList() {
    List<Widget> publications = new List<Widget>();
    MiniUser user1 = new MiniUser("sdicnwlas", "Daniel Quiroga P", "DquirogaP",
        "assets/user_images/user_6.png");
    MiniUser user2 = new MiniUser("sdicnwlas", "Otro nombre bien prron",
        "user209302891", "assets/user_images/user_4.png");
    Timestamp time = Timestamp.now();
    MiniBook mini1 = new MiniBook(
        '0312289510',
        'The Christmas Shoes',
        ['Donna VanLiere'],
        'http://images.amazon.com/images/P/0312289510.01.LZZZZZZZ.jpg');
    MiniBook mini2 = new MiniBook(
        '0786014555',
        'Dark Masques',
        ['J. N. Williamson'],
        'http://images.amazon.com/images/P/0786014555.01.LZZZZZZZ.jpg');
    Publication pub1 =
        new Publication(user1, "Hey! I really like this book.", time, mini2);
    Publication pub2 = new Publication(
        user2,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mattis, turpis ut cursus ullamcorper, libero nunc interdum magna, vel hendrerit nisl leo ut erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed lorem pellentesque purus laoreet ornare vel eget enim.",
        time,
        mini1);
    Publication pub3 = new Publication(
        user1,
        "Nulla et libero dapibus, viverra sem sed, ultrices nunc. In hac habitasse platea dictumst. In id interdum mauris. Donec luctus eget magna tempus dictum.",
        time,
        null);
    Publication pub4 = new Publication(
        user2,
        "Vestibulum lacus nunc, faucibus vel eleifend at, sagittis vitae erat.",
        time,
        mini2);
    publications.add(pub3.toWidget(context));
    publications.add(Divider());
    publications.add(pub1.toWidget(context));
    publications.add(Divider());
    publications.add(pub4.toWidget(context));
    publications.add(Divider());
    publications.add(pub2.toWidget(context));
    publications.add(Divider());
    publications.add(pub1.toWidget(context));
    publications.add(Divider());
    publications.add(pub3.toWidget(context));
    publications.add(Divider());
    publications.add(pub4.toWidget(context));
    publications.add(Divider());
    publications.add(pub2.toWidget(context));
    return publications;
  }
}
