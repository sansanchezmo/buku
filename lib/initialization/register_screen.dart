import 'package:buku/firebase/auth.dart';
import 'package:buku/widget/gradient_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<RegisterScreen> {

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orange,Colors.deepOrange]
              )
          ),
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/bukusymbol.png'),
                width: 200.0,
                height: 200.0,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                    //color: Colors.white,
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                            color: Colors.black38,
                            blurRadius: 20,
                            offset: Offset(0,0)
                        ),],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        )),
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
                                  borderSide:
                                      BorderSide(color: Colors.orange))),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orange))),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: 'NICK NAME',
                              labelStyle: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.orange))),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        GradientButton(
                          text: 'REGISTER',
                          tap: (){

                            Auth auth = new Auth();
                            auth.registerUser(emailController.text, passController.text, nameController.text, context);

                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          //padding: EdgeInsets.only(left: 30.0,right: 30.0),
                          height: 50.0,
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
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
                                  'Go Back',
                                  style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
