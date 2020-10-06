import 'package:buku/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';

class LoginScreen extends StatefulWidget {
  String email;
  String pass;
  LoginScreen({Key key, this.email = '', this.pass = ''});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
      //body: Center(child: Text('Hello World'),),
      resizeToAvoidBottomPadding: false,
      body: Container(
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
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'ProductSans',
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
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

                Auth auth = new Auth();
                auth.loginUser(emailController.text, passController.text, context);

              }
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              //padding: EdgeInsets.only(left: 30.0, right: 30.0),
              height: 50.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
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
    );
  }
}
