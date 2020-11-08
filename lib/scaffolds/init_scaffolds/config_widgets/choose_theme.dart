import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/config_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseTheme extends StatefulWidget{

  _ChooseThemeState createState() => _ChooseThemeState();

}

class _ChooseThemeState extends State<ChooseTheme>{
  String selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = CurrentTheme.getThemeKey();
    ConfigCache.theme = CurrentTheme.getThemeKey();
  }

  setSelectedRadio(String radio){
    ConfigCache.theme = radio;
    CurrentTheme.setTheme(radio, context: context);
    setState(() {
      selectedRadio = radio;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            ClipPath(
              clipper: Clip1(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: CurrentTheme.primaryGradientColorInverted,
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              child: Container(
                height: 200,
                padding: EdgeInsets.only(left: 20, right: 90),
                decoration: BoxDecoration(
                    color: CurrentTheme.backgroundContrast,
                    borderRadius: BorderRadius.only( topRight: Radius.circular(40),bottomRight: Radius.circular(40)),
                    boxShadow: [BoxShadow(
                        color: CurrentTheme.shadow2, blurRadius: 10, spreadRadius: 10
                    )]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'orange',
                          groupValue: selectedRadio,
                          activeColor: CurrentTheme.primaryColor,
                          onChanged: (val){
                            setSelectedRadio(val);
                          },
                        ),
                        GestureDetector(
                            onTap: (){
                              setSelectedRadio('orange');
                            },
                            child: Text(
                              'Orange',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: CurrentTheme.textColor2
                              ),
                            )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'dark',
                          groupValue: selectedRadio,
                          activeColor: CurrentTheme.primaryColor,
                          onChanged: (val){
                            setSelectedRadio(val);
                          },
                        ),
                        GestureDetector(
                            onTap: (){
                              setSelectedRadio('dark');
                            },
                            child: Text(
                              'Dark',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: CurrentTheme.textColor2
                              ),
                            )
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
            Positioned(
              top: 270, left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose the theme',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: CurrentTheme.textColor1,
                        fontSize: 40
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      'How would you like to see Buku interface?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CurrentTheme.textColor2,
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Clip1 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height/4.25);

    var firstControlpoint = Offset(size.width/4, size.height/5 - 40);
    var firstEndPoint = Offset(size.width/2, size.height/3 - 60);

    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width -(size.width/4), size.height/3 + 20);
    var secondEndPoint = Offset(size.width, size.height/3);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height/3);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}