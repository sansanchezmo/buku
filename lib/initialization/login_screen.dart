import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';

class LoginScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(child: Text('Hello World'),),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/bukunobackgroundfull.PNG'),
              width: 250.0,
              height: 250.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
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
            Container(
              //padding: EdgeInsets.only(left: 30.0, right: 30.0),
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Colors.orange,Colors.deepOrange]
                  )
              ),
              child: GestureDetector(
                onTap: () {

                  Auth auth = new Auth();
                  auth.loginUser(emailController.text, passController.text, context);

                },
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  //shadowColor: Colors.orangeAccent,
                  color: Colors.transparent,
                  //elevation: 7.0,
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'ProductSans',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
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
