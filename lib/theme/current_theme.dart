import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/themes/blue_dark.dart';
import 'package:buku/theme/themes/blue_light.dart';
import 'package:buku/theme/themes/dark_theme.dart';
import 'package:buku/theme/themes/orange_theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class CurrentTheme{

  static String _theme;

  static final String orangeTheme = 'orange';
  static final String darkTheme = 'dark';
  static final String blueDark = 'blue_dark';
  static final String blueLight = 'blue_light';

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
  static LinearGradient primaryGradientColorInverted;
  static LinearGradient primaryGradientColorVariant2;

  static ThemeData themeData;

  static final double borderRadius = 40;

  static setTheme(String option, {BuildContext context = null, saveUserTheme = true}){
    _theme = option;
    if(option == orangeTheme){
      textColor1 = OrangeTheme.textColor1;
      textColor2 = OrangeTheme.textColor2;
      textColor3 = OrangeTheme.textColor3;
      primaryColor = OrangeTheme.primaryColor;
      primaryColorVariant = OrangeTheme.primaryColorVariant;
      primaryGradientColor = OrangeTheme.primaryGradientColor;
      primaryGradientColorVariant = OrangeTheme.primaryGradientColorVariant;
      primaryGradientColorInverted = OrangeTheme.primaryGradientColorInverted;
      primaryGradientColorVariant2 = OrangeTheme.primaryGradientColorVariant2;
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
    }else if(option == darkTheme){
      textColor1 = DarkTheme.textColor1;
      textColor2 = DarkTheme.textColor2;
      textColor3 = DarkTheme.textColor3;
      primaryColor = DarkTheme.primaryColor;
      primaryColorVariant = DarkTheme.primaryColorVariant;
      primaryGradientColor = DarkTheme.primaryGradientColor;
      primaryGradientColorVariant = DarkTheme.primaryGradientColorVariant;
      primaryGradientColorInverted = DarkTheme.primaryGradientColorInverted;
      primaryGradientColorVariant2 = DarkTheme.primaryGradientColorVariant2;
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
    else if(option == blueDark){
      textColor1 = BlueDark.textColor1;
      textColor2 = BlueDark.textColor2;
      textColor3 = BlueDark.textColor3;
      primaryColor = BlueDark.primaryColor;
      primaryColorVariant = BlueDark.primaryColorVariant;
      primaryGradientColor = BlueDark.primaryGradientColor;
      primaryGradientColorVariant = BlueDark.primaryGradientColorVariant;
      primaryGradientColorInverted = BlueDark.primaryGradientColorInverted;
      primaryGradientColorVariant2 = BlueDark.primaryGradientColorVariant;
      shadow1 = BlueDark.shadow1;
      shadow2 = BlueDark.shadow2;
      separatorColor = BlueDark.separatorColor;
      backgroundContrast = BlueDark.backgroundContrast;
      background = BlueDark.background;
      searchBar = BlueDark.searchBar;
      searchBarIcon = BlueDark.searchBarIcon;
      searchBarText = BlueDark.searchBarText;
      textFieldHint = BlueDark.textFieldHint;
      navigatorBarColor = BlueDark.navigatorBarColor;
      themeData = BlueDark.getTheme();
    }
    else if(option == blueLight){
      textColor1 = BlueLight.textColor1;
      textColor2 = BlueLight.textColor2;
      textColor3 = BlueLight.textColor3;
      primaryColor = BlueLight.primaryColor;
      primaryColorVariant = BlueLight.primaryColorVariant;
      primaryGradientColor = BlueLight.primaryGradientColor;
      primaryGradientColorVariant = BlueLight.primaryGradientColorVariant;
      primaryGradientColorInverted = BlueLight.primaryGradientColorInverted;
      primaryGradientColorVariant2 = BlueLight.primaryGradientColorVariant;
      shadow1 = BlueLight.shadow1;
      shadow2 = BlueLight.shadow2;
      separatorColor = BlueLight.separatorColor;
      backgroundContrast = BlueLight.backgroundContrast;
      background = BlueLight.background;
      searchBar = BlueLight.searchBar;
      searchBarIcon = BlueLight.searchBarIcon;
      searchBarText = BlueLight.searchBarText;
      textFieldHint = BlueLight.textFieldHint;
      navigatorBarColor = BlueLight.navigatorBarColor;
      themeData = BlueLight.getTheme();
    }
    if(saveUserTheme) MainUser.setTheme(option);
    if(context != null){
      DynamicTheme.of(context).setThemeData(themeData);
    }
  }
  static ThemeData getTheme() {
    if(themeData == null)  throw ThemeException("There´s not any theme selected");
    return themeData;
  }
  static String getThemeKey(){

    return _theme;

  }

  static BoxShadow getBoxShadow({double blur = 10, double spread = 10}){

   return  BoxShadow(color: shadow1, spreadRadius: spread, blurRadius: blur);

  }
}

class ThemeException implements Exception{

  String cause;
  ThemeException(this.cause);

}