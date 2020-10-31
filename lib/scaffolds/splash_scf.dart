import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScaffold extends StatefulWidget {
  _SplashScaffoldState createState() => _SplashScaffoldState();
}

class _SplashScaffoldState extends State<SplashScaffold> {
  @override
  void initState() {
    checkUser();

    super.initState();
  }

  Future<bool> checkUser() async {
    User user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      if(user.emailVerified){
        Navigator.of(context).pushNamed('/menu');
      }else
        Navigator.of(context).pushNamed('/login');
    } else {
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                'assets/images/bukunobackgroundfull.PNG',
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
                    child: Text(
                      'FROM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      'NACHO',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}