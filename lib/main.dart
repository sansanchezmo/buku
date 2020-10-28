import 'package:buku/initialization/MainMenu.dart';
import 'package:buku/initialization/intro_screens/choose_theme.dart';
import 'package:buku/initialization/splash.dart';
import 'package:buku/initialization/user_config.dart';
import 'package:buku/themes/current_theme.dart';
import 'package:buku/themes/dark_theme.dart';
import 'package:buku/themes/orange_theme.dart';
import 'package:flutter/material.dart';
import 'package:buku/initialization/register_screen.dart';
import 'package:buku/database/database.dart';
import 'package:buku/initialization/login_screen.dart';
import 'package:buku/initialization/test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // bind app with FireBase
  await Database.createDatabase(); // bind app with SQL Database
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  MyApp(){
    CurrentTheme.setTheme("orange");
    //CurrentTheme.setT(OrangeTheme);
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'ProductSans', backgroundColor: Colors.black, scaffoldBackgroundColor: Colors.transparent),
      //theme: ThemeData.light(),
      //theme: DarkTheme.getTheme(),
      theme: CurrentTheme.getTheme(),
      routes: <String, WidgetBuilder>{
        //Here you can implement routes to every single file
        // used by the Navigator.
        '/register': (BuildContext context) => RegisterScreen(),
        '/menu': (BuildContext context) => Menu(2),
        '/login': (BuildContext context) => LoginScreen(),
        '/newUser': (BuildContext context) => UserConfig()
      },
      home: SplashScreen(),
      //home: Test(),
    );
  }
}
