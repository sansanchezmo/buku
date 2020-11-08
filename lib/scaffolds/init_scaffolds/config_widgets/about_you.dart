import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/config_cache.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutYou extends StatefulWidget {
  TextEditingController name;
  TextEditingController desc;
  AboutYou({Key key, this.name, this.desc});

  _AboutYouState createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final int numImages = 8;
  String url;

  @override
  void initState() {
    url = ConfigCache.userImageUrl == ""? "assets/user_images/user_0.png" : ConfigCache.userImageUrl;
    ConfigCache.userImageUrl = ConfigCache.userImageUrl == ""? "assets/user_images/user_0.png" : ConfigCache.userImageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        alignment: Alignment.center,
        children: <Widget>[
          ClipPath(
            clipper: Clip2(),
            child: Container(decoration: BoxDecoration(
                gradient: CurrentTheme.primaryGradientColorVariant)),

          ),
          Positioned(
            top: 105, right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'About you',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                Container(
                  width: 200,
                  child: Text(
                    'We want to learn some stuff about you',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white70, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 250),
                    GestureDetector(
                      onTap: () {
                        _showDialog(context);
                      },
                      child: Stack(children: [
                        ProfileAvatar(size: 150, profileImage: this.url),
                        Positioned(
                            top: 110,
                            right: 0,
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CurrentTheme.backgroundContrast),
                                child: Icon(Icons.edit,
                                    color: CurrentTheme.primaryColor))
                        )
                      ])
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: CurrentTheme.background,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Column(
                        children: [
                          TextField(
                            autofocus: false,
                            controller: widget.name,
                            cursorColor: CurrentTheme.textColor1,
                            style: TextStyle(color: CurrentTheme.textColor1),
                            decoration: InputDecoration(
                                labelText: 'Your name',
                                labelStyle: TextStyle(
                                    color: CurrentTheme.textFieldHint,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.primaryColorVariant)
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            autofocus: false,
                            controller: widget.desc,
                            cursorColor: CurrentTheme.textColor1,
                            maxLength: 250,
                            maxLines: 4,
                            style: TextStyle(color: CurrentTheme.textColor1),
                            decoration: InputDecoration(
                                labelText: 'Biography',
                                labelStyle: TextStyle(
                                    color: CurrentTheme.textFieldHint,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.primaryColorVariant)
                                )
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: CurrentTheme.background,
              title: Text(
                'Avatar',
                style: TextStyle(
                    color: CurrentTheme.textColor1,
                    fontWeight: FontWeight.bold),
              ),
              content: Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pick your favorite avatar.',
                        style: TextStyle(color: CurrentTheme.textColor2),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: userImages(),
                        ),
                      ),
                    ],
                  )),
            ));
  }

  userImages() {
    List<Widget> list = [];
    for (int i = 0; i < numImages ~/ 3; i++) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setProfileImage(
                  'assets/user_images/user_' + ((3 * i)).toString() + '.png');
            },
            child: ProfileAvatar(
                size: 70,
                profileImage:
                    'assets/user_images/user_' + ((3 * i)).toString() + '.png'),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setProfileImage('assets/user_images/user_' +
                  ((3 * i) + 1).toString() +
                  '.png');
            },
            child: ProfileAvatar(
                size: 70,
                profileImage: 'assets/user_images/user_' +
                    ((3 * i) + 1).toString() +
                    '.png'),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setProfileImage('assets/user_images/user_' +
                  ((3 * i) + 2).toString() +
                  '.png');
            },
            child: ProfileAvatar(
                size: 70,
                profileImage: 'assets/user_images/user_' +
                    ((3 * i) + 2).toString() +
                    '.png'),
          ),
        ],
      ));
    }
    if (numImages % 3 != 0) {
      List<Widget> lastRow = List<Widget>();
      for (int i = 0; i < numImages % 3; i++) {
        lastRow.add(
          GestureDetector(
            onTap: () {
              setProfileImage('assets/user_images/user_' +
                  ((numImages - numImages % 3) + i).toString() +
                  '.png');
            },
            child: ProfileAvatar(
                size: 70,
                profileImage: 'assets/user_images/user_' +
                    ((numImages - numImages % 3) + i).toString() +
                    '.png'),
          ),
        );
        lastRow.add(
          SizedBox(
            width: 10,
          ),
        );
      }
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: lastRow,
      ));
    }

    return list;
  }

  setProfileImage(String url) {
    ConfigCache.userImageUrl = url;
    setState(() {
      this.url = url;
    });
    Navigator.of(context).pop();
  }
}

class Clip2 extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 3);

    var firstControlpoint = Offset(size.width / 4, size.height / 3 - 20);
    var firstEndPoint = Offset(size.width / 2 - 20, size.height / 3 + 60);

    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(
        size.width - (size.width / 4), (size.height - size.height / 3) - 60);
    var secondEndPoint =
        Offset(size.width, (size.height - size.height / 3) - 80);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, (size.height - size.height / 3) - 80);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
