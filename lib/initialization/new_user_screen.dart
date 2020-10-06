import 'package:buku/widget/gradient_button.dart';
import 'package:buku/widget/gradient_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatefulWidget{
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 30,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientIcon(
              icon: Icons.filter_drama,
              size: 100,
            ),
            Text('hola k ace'),
            SizedBox(height: 50,),
            GradientButton(
              text: 'CONTINUE',
              tap: (){

                Navigator.of(context).pushNamed('/home');

                print("pos presionó jaja salu2");
              },
            )
          ],
        ),
      ),
    );
  }
}