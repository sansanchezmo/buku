import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

class registerScreen extends StatefulWidget{
  @override
  _registerScreenState createState() => _registerScreenState();
  }

class _registerScreenState extends State<registerScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.orange,
      body: Container(
        
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [

            Image(
              image: AssetImage('assets/images/firebase.png'),
              width: 150.0,
              height: 150.0,
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                  //color: Colors.white,
                padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )
                  ),
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
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)
                            )
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'NICK NAME',
                            labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)
                            )
                        ),
                      ),

                      SizedBox(height: 50.0,),

                      Container(
                        //padding: EdgeInsets.only(left: 30.0,right: 30.0),
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
                                'REGISTER',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        //padding: EdgeInsets.only(left: 30.0,right: 30.0),
                        height: 50.0,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.0
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                'Go Back',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
              ),
            )
          ],
        ),
      )
    );
  }
}
