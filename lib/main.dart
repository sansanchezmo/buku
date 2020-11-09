import 'package:buku/scaffolds/init_scaffolds/init_config_scf.dart';
import 'package:buku/scaffolds/init_scaffolds/login_scf.dart';
import 'package:buku/scaffolds/init_scaffolds/register_scf.dart';
import 'package:buku/scaffolds/main_scaffolds/main_menu_navbar.dart';
import 'package:buku/scaffolds/others_scaffolds/edit_profile_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/settings_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/test_pages_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/testdata_book_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/testdata_primitive_scf.dart';
import 'package:buku/scaffolds/splash_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:buku/scaffolds/test.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase/firestore.dart';
import 'main_objects/main_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // bind app with FireBase
  await MainUser.init(loadUserInfo: false); // initialize main user
  await setTheme();
  runApp(MyApp());
}

setTheme() async {
  /*the function bellow select the theme for initialize MyApp or set default theme
  if the user does not choose theme yet*/
  if (MainUser.currUser == null) {
    CurrentTheme.setTheme(CurrentTheme.orangeTheme);
  } else {
    try{
    String theme = await MainUser.getProfileTheme();
    CurrentTheme.setTheme(theme);
    } catch(e){
      CurrentTheme.setTheme(CurrentTheme.orangeTheme);
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      //This widgets allows us to change the whole theme in runtime
      // ignore: non_constant_identifier_names
      data: (Brightness) => CurrentTheme.getTheme(),
      themedWidgetBuilder: (context, theme) {
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
              '/editprofile': (BuildContext context) => EditProfileScaffold(),
              '/testpages': (BuildContext context) => TestPagesScaffold(),
              '/testprimitive': (BuildContext context) =>
                  PrimitiveTestScaffold(),
              '/testbook': (BuildContext context) => BookTestScaffold(),
            },
            home: SplashScaffold(),
          ),
          onTap: () {
            //this part is used to fix some Text Field bugs
            FocusScopeNode current = FocusScope.of(context);
            if (!current.hasPrimaryFocus && current.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
        );
      },
    );
  }
}
