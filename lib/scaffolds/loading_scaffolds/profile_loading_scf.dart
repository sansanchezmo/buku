import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileLoadingScaffold extends StatefulWidget {
  @override
  _ProfileLoadingScaffoldState createState() => _ProfileLoadingScaffoldState();
}

class _ProfileLoadingScaffoldState extends State<ProfileLoadingScaffold> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation1;
  Animation<Color> _colorAnimation2;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );
    _colorAnimation1 = ColorTween(
        begin: Colors.blueGrey,
        end: Colors.grey
    ).animate(_controller);
    _colorAnimation2 = ColorTween(
        begin: Colors.grey,
        end: Colors.blueGrey
    ).animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      if(_controller.status == AnimationStatus.completed){
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed){
        _controller.forward();
      }
      this.setState(() {});
    });
  }

  @override void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: CurrentTheme.primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                                color: CurrentTheme.shadow1,
                                spreadRadius: 5,
                                blurRadius: 30)
                          ]),
                    ),
                    SizedBox(height: 80,),
                    _loadingContainer(160,25),
                    SizedBox(height: 30),
                    _loadingContainer(130,20),
                    SizedBox(height: 50),
                    _loadingContainer(300,300),
                  ],
                ),
                Positioned(
                    top:90,
                    child: Container(
                      height: 100, width: 100,
                      decoration: BoxDecoration(
                          color: CurrentTheme.background,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: CurrentTheme.background,
                              width: 2
                          )
                      ),
                    )
                ),
                Positioned(
                    top:90,
                    child: Opacity(
                      opacity: 0.2,
                      child: Container(
                        height: 100, width: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [_colorAnimation1.value,_colorAnimation2.value]
                            ),
                            shape: BoxShape.circle
                        ),
                      ),
                    )
                ),
              ],
            )
          ],
        )
    );
  }

  Widget _loadingContainer(double width, double height){
    return Opacity(
      opacity: 0.2,
      child: Container(
        width: width,height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [_colorAnimation1.value,_colorAnimation2.value]
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }

}