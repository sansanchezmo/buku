import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/structs/linked_list.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buku/database/database.dart';
import 'package:buku/main_objects/structs/queue.dart';
import 'package:buku/main_objects/structs/stack.dart';
import 'package:buku/main_objects/structs/vector.dart';
import 'package:buku/scaffolds/others_scaffolds/tag_cloud_scf.dart';
import 'package:swipe_to/swipe_to.dart';

class MainPageScaffold extends StatefulWidget {
  _MainPageScaffoldState createState() => _MainPageScaffoldState();
}

class _MainPageScaffoldState extends State<MainPageScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Test',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CurrentTheme.searchBarText,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: CurrentTheme.searchBarIcon,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.timeline),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/testpages');
                          print('You pressed the icon.');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),

//-----------------------------First_Widget-------------------------------------
              // Divider (--RECOMMENDS--)
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        thickness: 0.0,
                        color: Colors.transparent,
                        height: 36,
                      )),
                ),
                Center(
                  child: SizedBox(
                    width: 250.0,
                    child: ColorizeAnimatedTextKit(
                        repeatForever: false,
                        totalRepeatCount: 1.0,
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "Recommends",
                          "Recommends",
                          "Recommends",
                        ],
                        textStyle: TextStyle(
                          fontSize: 40.0,
                          fontFamily: "ProductSans",
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.indigoAccent[100],
                          Colors.indigoAccent[200],
                          Colors.lightBlueAccent,
                          Colors.blue,
                        ],
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional
                            .topStart // or Alignment.topLeft
                        ),
                  ),
                ),
                Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        thickness: 0.0,
                        color: Colors.transparent,
                        height: 36,
                      )),
                ),
              ]),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Find books that fit to your pleasures.',
                  style: TextStyle(
                    color: CurrentTheme.textColor1,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SwipeTo(
                offsetDx: 2.0,
                onLeftSwipe: () {
                  print('Left swipe');
                },
                onRightSwipe: () {
                  print('Right swipe');
                },
                leftSwipeWidget: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 50.0,
                  ),
                ),
                rightSwipeWidget: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
                child: Container(
                  child: Image(
                    image: AssetImage(
                      'assets/images/open-book.png',
                    ),
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Swipe ',
                          style: TextStyle(
                              fontSize: 15, color: CurrentTheme.textColor1)),
                      TextSpan(
                          text: 'LEFT ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green)),
                      TextSpan(
                          text: 'to ',
                          style: TextStyle(
                              fontSize: 15, color: CurrentTheme.textColor1)),
                      TextSpan(
                          text: 'SAVE. ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Swipe ',
                          style: TextStyle(
                              fontSize: 15, color: CurrentTheme.textColor1)),
                      TextSpan(
                          text: 'RIGHT ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red)),
                      TextSpan(
                          text: 'to ',
                          style: TextStyle(
                              fontSize: 15, color: CurrentTheme.textColor1)),
                      TextSpan(
                          text: 'DISMISS. ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),

//-----------------------------Second_Widget------------------------------------
              // Divider (- Write Here the Second Widget's name -)
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Second Widget",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: CurrentTheme.textColor3,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProductSans',
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              // --- Add your widget HERE --
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 30.0),

//-----------------------------Third_Widget-------------------------------------
              // Divider (- Write Here the Third Widget's name -)
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Thirth Widget",
                    style: TextStyle(
                      color: CurrentTheme.textColor3,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProductSans',
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              // --- Add your widget HERE --
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 30.0),

//-----------------------------Fourth_Widget------------------------------------
              // Divider (- Write Here the Fourth Widget's name -)
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Fourth Widget",
                    style: TextStyle(
                      color: CurrentTheme.textColor3,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProductSans',
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              // --- Add your widget HERE --
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
