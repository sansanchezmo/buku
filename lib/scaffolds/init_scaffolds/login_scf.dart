import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class LoginScaffold extends StatefulWidget {
  String email;
  String pass;
  LoginScaffold({Key key, this.email = '', this.pass = ''});
  @override
  _LoginScaffoldState createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<LoginScaffold> {

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  void initState(){

    emailController.text = widget.email;
    passController.text = widget.pass;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50.0, left: 30, right: 30),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/bukunobackgroundfull.PNG'),
                width: 250.0,
                height: 250.0,
              ),
              Container(
                padding: EdgeInsets.only( top: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: false,
                      controller: emailController,
                      cursorColor: CurrentTheme.textColor1,
                      style: TextStyle(color: CurrentTheme.textColor1),
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'ProductSans',
                              color: CurrentTheme.textFieldHint,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: CurrentTheme.textColor1)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: CurrentTheme.primaryColor))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      autofocus: false,
                      controller: passController,
                      cursorColor: CurrentTheme.textColor1,
                      style: TextStyle(color: CurrentTheme.textColor1),
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            color: CurrentTheme.textFieldHint, fontWeight: FontWeight.bold),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CurrentTheme.textColor1)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CurrentTheme.primaryColor)),
                      ),
                      obscureText: true,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              GradientButton(
                text: 'LOGIN',
                tap: () {
                  MainUser().login(emailController.text, passController.text, context);
                }
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50.0,
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: CurrentTheme.textColor1,
                          style: BorderStyle.solid,
                          width: 2.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: CurrentTheme.textColor1,
                            fontSize: 16.0,
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
