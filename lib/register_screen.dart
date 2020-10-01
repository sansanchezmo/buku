import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

class registerScreen extends StatefulWidget{
  @override
  _registerScreenState createState() => _registerScreenState();
  }

class _registerScreenState extends State<registerScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('hello world'),),
    );
  }
}