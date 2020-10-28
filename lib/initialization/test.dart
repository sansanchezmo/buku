import 'package:buku/initialization/intro_screens/choose_theme.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';
import 'package:flutter/cupertino.dart';

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Auth auth = new Auth();
  String email;
  @override
  Widget build(BuildContext context) {
    auth.getEmail();
    email = auth.email;
    return Scaffold(
      body: ChooseTheme()
    );
  }
}
