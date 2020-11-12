import 'package:buku/main_objects/main_user.dart';
import 'package:buku/scaffolds/main_scaffolds/main_menu_navbar.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingsScaffold extends StatefulWidget{
  @override
  _SettingsScaffoldState createState() => _SettingsScaffoldState();
}

class _SettingsScaffoldState extends State<SettingsScaffold>{
  String selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = CurrentTheme.getThemeKey();
  }

  setSelectedRadio(String radio){
    CurrentTheme.setTheme(radio, context: context);
    setState(() {
      selectedRadio = radio;
    });
  }

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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu(4)));
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
              onTapFunction: (){
                Navigator.pushNamed(context, '/editprofile');
              }
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
                onTapFunction: (){MainUser.signOut(context);}
            ),
            Divider(height: 0.1, thickness: 1,),
          ],
        )
    );
  }

  Widget _menuButton({@required IconData icon, @required String text, @required Color color, @required Function onTapFunction}){
    return SizedBox(
      //height: 65,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RaisedButton(
          textColor: color,
          onPressed: onTapFunction,
          elevation: 0,
          color: Colors.transparent,
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
          padding: EdgeInsets.only(
              top:20.0, bottom: 20.0,
              left:30.0, right: 30.0),
        ),
      ),
    );
  }

  void _changeThemeWidget(){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) =>  AlertDialog(
          title: Text("Choose the theme you like",
          style: TextStyle(color: CurrentTheme.textColor1)),
          backgroundColor: CurrentTheme.background,
          content: _themeOptions(),
          actions: <Widget>[
            FlatButton(
              textColor: CurrentTheme.primaryColor,
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

  Widget _themeOptions(){
    return SizedBox(
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio(
                value: 'orange',
                groupValue: selectedRadio,
                activeColor: CurrentTheme.primaryColor,
                onChanged: (val){
                  setSelectedRadio(val);
                },
              ),
              GestureDetector(
                  onTap: (){
                    setSelectedRadio('orange');
                  },
                  child: Text(
                    'Orange',
                    style: TextStyle(
                        fontSize: 18,
                        color: CurrentTheme.textColor2
                    ),
                  )
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 'dark',
                groupValue: selectedRadio,
                activeColor: CurrentTheme.primaryColor,
                onChanged: (val){
                  setSelectedRadio(val);
                },
              ),
              GestureDetector(
                  onTap: (){
                    setSelectedRadio('dark');
                  },
                  child: Text(
                    'Dark',
                    style: TextStyle(
                        fontSize: 18,
                        color: CurrentTheme.textColor2
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );

  }

}