import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(Buku());

class Buku extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initScreen(),

    );
  }

}

class initScreen extends StatefulWidget{
  @override
  _initScreenState createState() => _initScreenState();
}

class _initScreenState extends State<initScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text('Hello World'),),

    );
  }
}

