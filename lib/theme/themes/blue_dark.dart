import 'package:flutter/material.dart';

class BlueDark extends Theme{

  static Color textColor1 = Color.fromARGB(255, 245, 246, 250);
  static Color textColor2 = Color.fromARGB(255, 220, 221, 225);
  static Color textColor3 = Color.fromARGB(230, 220, 221, 225);
  static Color primaryColor = Color.fromARGB(255, 0, 20, 255);
  static Color primaryColorVariant = Color.fromARGB(255, 255, 44, 223);
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

  static LinearGradient primaryGradientColor = LinearGradient(colors: [primaryColorVariant, primaryColor]);
  static LinearGradient primaryGradientColorVariant = LinearGradient(colors: [primaryColorVariant,Colors.purpleAccent, primaryColorVariant]);
  static LinearGradient primaryGradientColorInverted = LinearGradient(colors: [primaryColor, primaryColorVariant]);

  static ThemeData getTheme(){
    return ThemeData(

        fontFamily: 'ProductSans',
        scaffoldBackgroundColor: Color.fromARGB(255, 47, 54, 64 ),
        unselectedWidgetColor: textColor1
    );
  }
}