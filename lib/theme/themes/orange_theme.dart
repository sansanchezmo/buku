import 'package:flutter/material.dart';

class OrangeTheme extends Theme{

  static Color textColor1 = Colors.black87;
  static Color textColor2 = Colors.black54;
  static Color textColor3 = Color.fromRGBO(38, 38, 38, 0.8);
  static Color primaryColor = Colors.deepOrange;
  static Color primaryColorVariant = Colors.orange;
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

  static LinearGradient primaryGradientColor = LinearGradient(colors: [Colors.orange, Colors.deepOrange]);
  static LinearGradient primaryGradientColorVariant = LinearGradient(colors: [Colors.orange, Colors.orange]);

  static ThemeData getTheme(){
    return ThemeData(

        fontFamily: 'ProductSans',
        scaffoldBackgroundColor: Colors.grey[50],
      unselectedWidgetColor: textColor1
    );
  }
}