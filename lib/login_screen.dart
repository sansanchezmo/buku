import 'package:flutter/material.dart';
import 'register_screen.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(Buku());

class Buku extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/register':(BuildContext context)  => registerScreen()
      },
      home: initScreen(),

    );
  }

}

class initScreen extends StatefulWidget{
  @override
  _initScreenState createState() => _initScreenState();
}

class _initScreenState extends State<initScreen>{
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
              image: AssetImage('assets/images/firebase.png'),
              width: 200.0,
              height: 200.0,
            ),

            Container(
              padding: EdgeInsets.only(left: 30.0,right: 30.0,top: 20.0),
              child: Column(

                children: <Widget>[

                  TextField(
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)
                      )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)
                      ),
                    ),
                    obscureText: true,
                  )
                ],
              ),
            ),

            SizedBox(height: 50.0,),
            Container(
              padding: EdgeInsets.only(left: 30.0,right: 30.0),
              height: 50.0,
              child: Material(

                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.orangeAccent,
                color: Colors.orange,
                elevation: 7.0,
                child: GestureDetector(

                  onTap: (){},
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  'New in Buku?',
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                SizedBox(width: 10.0,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],

        ),
      ),

    );
  }
}

