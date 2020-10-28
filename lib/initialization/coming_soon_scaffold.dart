import 'package:buku/themes/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommingSoonPage extends StatefulWidget {
  @override
  _CommingSoonPage createState() => _CommingSoonPage();
}

class _CommingSoonPage extends State<CommingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(gradient: CurrentTheme.primaryGradientColor),
        child: Center(
          child: Container(
              alignment: Alignment.center,
              height: 450,
              decoration: BoxDecoration(
                  color: CurrentTheme.backgroundContrast,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: CurrentTheme.shadow2, blurRadius: 10, spreadRadius: 10)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 90, color: CurrentTheme.searchBarText),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Coming Soon...",
                    style: TextStyle(color: CurrentTheme.textColor1,fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "We are working on it.",
                    style: TextStyle(color: CurrentTheme.textColor1,fontSize: 15),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
