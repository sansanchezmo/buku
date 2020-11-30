import 'package:flutter/material.dart';

class BlueLight extends Theme{

  static Color textColor1 = Colors.black87;
  static Color textColor2 = Colors.black54;
  static Color textColor3 = Color.fromRGBO(38, 38, 38, 0.8);
  static Color primaryColor = Color.fromARGB(255, 0, 20, 255);
  static Color primaryColorVariant = Color.fromARGB(255, 255, 44, 223);
  static Color shadow1 = Colors.black38;
  static Color shadow2 = Colors.black12;
  static Color separatorColor = Color.fromRGBO(38, 38, 38, 0.1);
  static Color backgroundContrast = Colors.white;
  static Color background = Colors.grey[50];
  static Color searchBar = Colors.white70;
  static Color searchBarIcon = Colors.black12;
  static Color searchBarText = Colors.black38;
  static Color textFieldHint = Colors.grey;
  static Color navigatorBarColor = Colors.white;

  static LinearGradient primaryGradientColor = LinearGradient(colors: [primaryColorVariant, primaryColor]);
  static LinearGradient primaryGradientColorVariant = LinearGradient(colors: [primaryColorVariant,Colors.purpleAccent, primaryColorVariant]);
  static LinearGradient primaryGradientColorInverted = LinearGradient(colors: [primaryColor, primaryColorVariant]);

  static ThemeData getTheme(){
    return ThemeData(

        fontFamily: 'ProductSans',
        scaffoldBackgroundColor: Colors.grey[50],
        unselectedWidgetColor: textColor1
    );
  }
}