import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDanielScaffold extends StatefulWidget{

  @override
  _TestDanielScaffoldState createState() => _TestDanielScaffoldState();

}

class _TestDanielScaffoldState extends State<TestDanielScaffold>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200,),
          Container(
            height: 16,
            width: 10,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("http://images.amazon.com/images/P/0195153448.01.LZZZZZZZ.jpg")
              )
            ),
          )


        ],
      ),
    );
 }

}