import 'package:buku/themes/dark_theme.dart';
import 'package:buku/themes/orange_theme.dart';
import 'package:flutter/material.dart';

class CurrentTheme{

  static Color textColor1;
  static Color textColor2;
  static Color textColor3;
  static Color primaryColor;
  static Color primaryColorVariant;
  static Color shadow1;
  static Color shadow2;
  static Color separatorColor;
  static Color backgroundContrast;
  static Color background;
  static Color searchBar;
  static Color searchBarIcon;
  static Color searchBarText;
  static Color textFieldHint;
  static Color navigatorBarColor;

  static LinearGradient primaryGradientColor;
  static LinearGradient primaryGradientColorVariant;

  static ThemeData themeData;

  static setTheme(String option){
    if(option == "orange"){
      textColor1 = OrangeTheme.textColor1;
      textColor2 = OrangeTheme.textColor2;
      textColor3 = OrangeTheme.textColor3;
      primaryColor = OrangeTheme.primaryColor;
      primaryColorVariant = OrangeTheme.primaryColorVariant;
      primaryGradientColor = OrangeTheme.primaryGradientColor;
      primaryGradientColorVariant = OrangeTheme.primaryGradientColorVariant;
      shadow1 = OrangeTheme.shadow1;
      shadow2 = OrangeTheme.shadow2;
      separatorColor = OrangeTheme.separatorColor;
      backgroundContrast = OrangeTheme.backgroundContrast;
      background = OrangeTheme.background;
      searchBar = OrangeTheme.searchBar;
      searchBarIcon = OrangeTheme.searchBarIcon;
      searchBarText = OrangeTheme.searchBarText;
      textFieldHint = OrangeTheme.textFieldHint;
      navigatorBarColor = OrangeTheme.navigatorBarColor;
      themeData = OrangeTheme.getTheme();
    }else if(option == "dark"){
      textColor1 = DarkTheme.textColor1;
      textColor2 = DarkTheme.textColor2;
      textColor3 = DarkTheme.textColor3;
      primaryColor = DarkTheme.primaryColor;
      primaryColorVariant = DarkTheme.primaryColorVariant;
      primaryGradientColor = DarkTheme.primaryGradientColor;
      primaryGradientColorVariant = DarkTheme.primaryGradientColorVariant;
      shadow1 = DarkTheme.shadow1;
      shadow2 = DarkTheme.shadow2;
      separatorColor = DarkTheme.separatorColor;
      backgroundContrast = DarkTheme.backgroundContrast;
      background = DarkTheme.background;
      searchBar = DarkTheme.searchBar;
      searchBarIcon = DarkTheme.searchBarIcon;
      searchBarText = DarkTheme.searchBarText;
      textFieldHint = DarkTheme.textFieldHint;
      navigatorBarColor = DarkTheme.navigatorBarColor;
      themeData = DarkTheme.getTheme();
    }
  }
  static ThemeData getTheme() {
    if(themeData == null)  throw ThemeException("There´s not any theme selected");
    return themeData;
  }

  static setT(T){

    textColor1 = T.textColor1;
    textColor2 = T.textColor2;
    textColor3 = T.textColor3;
    primaryColor = T.primaryColor;
    primaryColorVariant = T.primaryColorVariant;
    primaryGradientColor = T.primaryGradientColor;
    primaryGradientColorVariant = T.primaryGradientColorVariant;
    shadow1 = T.shadow1;
    themeData = T.getTheme();

  }
}

class ThemeException implements Exception{

  String cause;
  ThemeException(this.cause);

}