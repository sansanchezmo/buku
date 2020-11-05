import 'package:buku/scaffolds/init_scaffolds/init_config_scf.dart';
import 'package:buku/scaffolds/init_scaffolds/login_scf.dart';
import 'package:buku/scaffolds/init_scaffolds/register_scf.dart';
import 'package:buku/scaffolds/main_scaffolds/main_menu_navbar.dart';
import 'package:buku/scaffolds/others_scaffolds/settings_scf.dart';
import 'package:buku/scaffolds/splash_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:buku/database/database.dart';
import 'package:buku/scaffolds/test.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main_objects/main_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // bind app with FireBase
  await Database.createDatabase(); // bind app with SQL Database
  await setTheme();
  runApp(MyApp());
}
setTheme() async{
  /*the function bellow select the theme for initialize MyApp or set default theme
  if the user does not choose theme yet*/
  var user = MainUser();
  if(user.currUser == null) {
    CurrentTheme.setTheme(CurrentTheme.orangeTheme);
  }else{
    String theme = await user.getProfileTheme();
    CurrentTheme.setTheme(theme);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme( //This widgets allows us to change the whole theme in runtime
      data: (Brightness) => CurrentTheme.getTheme(),
      themedWidgetBuilder: (context, theme){
        return GestureDetector(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            routes: <String, WidgetBuilder>{
              //Here you can implement routes to every single file
              // used by the Navigator.
              '/register': (BuildContext context) => RegisterScaffold(),
              '/menu': (BuildContext context) => Menu(2),
              '/login': (BuildContext context) => LoginScaffold(),
              '/newUser': (BuildContext context) => InitConfigScaffold(),
              '/settings': (BuildContext context) => SettingsScaffold(),
            },
            home: SplashScaffold(),
          ),
          onTap: (){
            //this part is used to fix some Text Field bugs
            FocusScopeNode current = FocusScope.of(context);
            if(!current.hasPrimaryFocus && current.focusedChild != null){
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
        );

      },
    );
  }
}
