import 'package:buku/main_objects/main_user.dart';
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

  Future<void> checkUser() async {
    User user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      if(user.emailVerified){
        await MainUser.init();
        Navigator.of(context).pushReplacementNamed('/menu');
      }else
        Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
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
