import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingsScaffold extends StatefulWidget{
  @override
  _SettingsScaffoldState createState() => _SettingsScaffoldState();
}

class _SettingsScaffoldState extends State<SettingsScaffold>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: CurrentTheme.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top:22,left:20.0),
              decoration: BoxDecoration(
                color: CurrentTheme.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon( Icons.arrow_back_ios,
                      color: CurrentTheme.background,
                      size: 25.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text("Settings",
                  style: TextStyle(
                    color: CurrentTheme.background,
                    fontSize: 20.0,
                  ),)
                ],
              )
            ),
            _menuButton(
              icon: Icons.edit,
              text: "Edit Profile",
              color: CurrentTheme.textColor3,
              onTapFunction: (){}
            ),
            Divider(height: 0.1, thickness: 1,),
            _menuButton(
                icon: Icons.palette,
                text: "Change Theme",
                color: CurrentTheme.textColor3,
                onTapFunction: (){ _changeThemeWidget();}
            ),
            Divider(height: 0.1, thickness: 1,),
            _menuButton(
                icon: Icons.error_outline,
                text: "Sign out",
                color: CurrentTheme.primaryColor,
                onTapFunction: (){MainUser().signOut(context);}
            ),
            Divider(height: 0.1, thickness: 1,),
          ],
        )
    );
  }

  Widget _menuButton({@required IconData icon, @required String text, @required Color color, @required Function onTapFunction}){
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
            top:20.0, bottom: 20.0,
            left:30.0, right: 30.0),
        child: Row(
          children: [
            Icon(icon,
                size: 20,
                color: color),
            SizedBox(width: 15),
            Text(text,
              style: TextStyle(
                  fontSize: 16,
                  color: color
              ),),
          ],
        ),
      ),
    );
  }

  void _changeThemeWidget(){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) =>  AlertDialog(
          title: Text("Choose your favourite theme!"),
          content: CustomScrollView(
            primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(20),
                  sliver: SliverGrid.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){},
                        )

                      ],
                  ),
                )
              ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close me!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

  Widget _themeOption(Color color,String theme){

  }

}