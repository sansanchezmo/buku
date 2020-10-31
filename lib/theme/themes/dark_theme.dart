import 'package:flutter/material.dart';

class DarkTheme extends Theme{

  static Color textColor1 = Color.fromARGB(255, 245, 246, 250);
  static Color textColor2 = Color.fromARGB(255, 220, 221, 225);
  static Color textColor3 = Color.fromARGB(230, 220, 221, 225);
  static Color primaryColor = Colors.deepOrange;
  static Color primaryColorVariant = Colors.orange;
  static Color shadow1 = Colors.black38;
  static Color shadow2 = Colors.black12;
  static Color separatorColor = Color.fromARGB(100, 245, 246, 250);
  static Color backgroundContrast = Color.fromARGB(255, 53, 59, 72 );
  static Color background = Color.fromARGB(255, 47, 54, 64 );
  static Color searchBar = Colors.white70;
  static Color searchBarIcon = Colors.black12;
  static Color searchBarText = Colors.black38;
  static Color textFieldHint = Colors.grey;
  static Color navigatorBarColor = Color.fromARGB(255, 38, 43, 51);

  static LinearGradient primaryGradientColor = LinearGradient(colors: [Colors.orange, Colors.deepOrange]);
  static LinearGradient primaryGradientColorVariant = LinearGradient(colors: [Colors.orange, Colors.orange]);

  static ThemeData getTheme(){
    return ThemeData(

      fontFamily: 'ProductSans',
      scaffoldBackgroundColor: Color.fromARGB(255, 47, 54, 64 ),
      unselectedWidgetColor: textColor1
      );
  }
}