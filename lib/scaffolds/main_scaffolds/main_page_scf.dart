import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buku/firebase/ML_kit.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/read_list.dart';
import 'package:buku/main_objects/structs/linked_list.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/book_horizontal_slider.dart';
import 'package:buku/widgets/recommended_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buku/database/database.dart';
import 'package:buku/main_objects/structs/queue.dart';
import 'package:buku/main_objects/structs/stack.dart';
import 'package:buku/main_objects/structs/vector.dart';
import 'package:buku/scaffolds/others_scaffolds/tag_cloud_scf.dart';
import 'package:swipe_to/swipe_to.dart';

Firestore _store = new Firestore();

class MainPageScaffold extends StatefulWidget {
  _MainPageScaffoldState createState() => _MainPageScaffoldState();
}

class _MainPageScaffoldState extends State<MainPageScaffold> {
  ArrayQueue<MiniBook> recommendsQueue = new ArrayQueue<MiniBook>();

  @override
  Widget build(BuildContext context) {
    recommendsQueue.empty() == true
        ? addInfo()
        : print('Recommendations found. No info added');
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
                  Image(
                    height: 30,
                    width: 30,
                    image: AssetImage(
                      'assets/images/bukusymbol.png',
                    ),
                  ),
                  SizedBox(width: 60),
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
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        final gradient = LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.yellow, Colors.red],
                        );
                        return gradient.createShader(Offset.zero & bounds.size);
                      },
                      child: Text(
                        'Recommends',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          color: Colors
                              .white, // must be white for the gradient shader to work
                        ),
                      ),
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
                  'Find books that fit to your pleasures',
                  style: TextStyle(
                    color: CurrentTheme.textColor1,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  /*boxShadow: [
                    BoxShadow(
                      color: CurrentTheme.shadow1,
                      spreadRadius: 6, //(x,y)
                      blurRadius: 20.0,
                    ),
                  ],*/
                  gradient: CurrentTheme.primaryGradientColor,
                ),
                child: SwipeTo(
                  offsetDx: 2.0,
                  onLeftSwipe: () {
                    setState(() {
                      recommendsQueue.dequeue();
                      print('Left swipe');
                    });
                  },
                  onRightSwipe: () {
                    setState(() {
                      recommendsQueue.dequeue();
                      print('Right swipe');
                    });
                  },
                  leftSwipeWidget: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.greenAccent[400],
                      size: 50.0,
                    ),
                  ),
                  rightSwipeWidget: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red[700],
                      size: 50.0,
                    ),
                  ),
                  child: recommendsQueue.empty() == true
                      ? Container(
                          child: Image(
                            image: NetworkImage(
                                'https://image.flaticon.com/icons/png/512/152/152565.png'),
                            width: 150.0,
                            height: 345.0,
                          ),
                        )
                      : recommendsQueue.front().toBigWidget(context),
                ),
              ),
              SizedBox(height: 10.0),
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

//-----------------------------Second_Widget------------------------------------
              BookHorizontalSlider(
                "Book history",
                MainUser.openHistory,
                  Container(
                    width: 250,
                    child: Text("You haven\'t seen any books yet. Keep discovering new content!",
                        style: TextStyle(color: CurrentTheme.textColor3)),
                  )
              ),

//-----------------------------Third_Widget-------------------------------------
              // Divider (- Write Here the Third Widget's name -)
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Maybe it interest you",
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
              RecommendedListWidget(
                getReadlistStack()
              ),
              SizedBox(height: 30.0),

//-----------------------------Fourth_Widget------------------------------------
              // Divider (- Tag cloud -)
              /*Row(children: <Widget>[
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
              ]),*/
              TagCloud(), // --- Add your widget HERE --
              /*
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  void addInfo(){
    ArrayQueue<MiniBook> arrayQueue = ML.getRecommendedBookQueue(20);
    setState(() {
      recommendsQueue = arrayQueue;
      print('Queue succesfully created');
    });
  }

  ListStack<ReadList> getReadlistStack(){
    ListStack<ReadList> stack = ListStack<ReadList>();
    var list = ML.getRecommendedReadList(4);
    for(var item in list){
      stack.push(item);
    }
    return stack;

  }
}
