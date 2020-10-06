import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Auth auth = new Auth();
  String email;
  @override
  Widget build(BuildContext context) {
    auth.getEmail();
    email = auth.email;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                'assets/images/bukusymbol.png',
              ),
              width: 200.0,
              height: 200.0,
            ),
            Text(
              'You logged in with:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 25.0,
                fontFamily: 'ProductSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              email,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'ProductSans',
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        auth.signout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (r) => false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  spreadRadius: 2)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'SIGN OUT',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
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
