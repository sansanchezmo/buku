import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';

class Test extends StatefulWidget{

  _TestState createState() => _TestState();

}

class _TestState extends State<Test>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: [

            Image(
              image: AssetImage(
                'assets/images/firebase.png',
              ),
              width: 200.0,
              height: 200.0,
            ),

            Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(

                        child: GestureDetector(
                          onTap: (){

                            Auth auth = new Auth();
                            auth.signout();
                            Navigator.of(context).pushNamed('/login');

                          },
                          child: Text(
                            'SIGN OUT',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}