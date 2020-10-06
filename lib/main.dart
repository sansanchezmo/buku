import 'package:buku/initialization/MainMenu.dart';
import 'package:buku/initialization/splash.dart';
import 'package:flutter/material.dart';
import 'package:buku/initialization/register_screen.dart';
import 'package:buku/initialization/login_screen.dart';
import 'package:buku/initialization/test.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // bind app with FireBase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'ProductSans'),
      routes: <String, WidgetBuilder>{
        //Here you can implement routes to every single file
        // used by the Navigator.
        '/register': (BuildContext context) => RegisterScreen(),
        '/menu': (BuildContext context) => Menu(2),
        '/login': (BuildContext context) => LoginScreen()
      },
      home: SplashScreen(),
    );
  }
}
