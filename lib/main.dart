import 'package:flutter/material.dart';
import 'package:buku/login_screen.dart';
import 'package:buku/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        //Here you can implement routes to every single file
        // used by the Navigator.
        '/register': (BuildContext context) => registerScreen()
      },
      home: LoginScreen(),
    );
  }
}
