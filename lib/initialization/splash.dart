import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{

  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){

      checkUser();

      super.initState();
  }

  Future<bool> checkUser() async{

    if(await FirebaseAuth.instance.currentUser != null){

      Navigator.of(context).pushNamed('/home');

    }else {
      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 150),
        color: Colors.orange,
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
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
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