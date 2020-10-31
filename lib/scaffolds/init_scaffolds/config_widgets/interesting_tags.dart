import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config_cache.dart';

class InterestingTags extends StatefulWidget{
  TextEditingController name;
  TextEditingController desc;

  InterestingTags({Key key, this.name, this.desc});

  _InterestingTagsState createState() => _InterestingTagsState();

}

class _InterestingTagsState extends State<InterestingTags>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: Clip3(),
              child: Container(
                color: CurrentTheme.primaryColor,
              ),
            ),
            Positioned(
                top: 150, right: 10,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Tags you\nshould know',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CurrentTheme.textColor1,
                            fontWeight: FontWeight.bold,
                            fontSize: 40
                        ),
                      ),
                      Text(
                        'Maybe you can find \nsome tags to follow',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: CurrentTheme.textColor2,
                            fontSize: 18
                        ),
                      )
                    ],
                  ),
                )
            ),
            Positioned(
              bottom: 90,
              child: _favTagsWidget(),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onTap: () async {

                  ConfigCache.name = widget.name.text;
                  ConfigCache.description = widget.desc.text;

                  if(ConfigCache.nameEmpty()) ConfigCache.name = await MainUser().getNickName() ;
                  if(ConfigCache.descriptionEmpty()) ConfigCache.description = 'Hi there! I´m using Buku';

                  ConfigCache.storeCache();

                  Navigator.of(context).pushNamed('/menu');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: CurrentTheme.primaryColor,
                    //boxShadow: [BoxShadow(color: CurrentTheme.shadow2,spreadRadius: 5,blurRadius: 5)],
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                  child: Text('DONE', style: TextStyle(
                    color: CurrentTheme.background,
                    fontWeight: FontWeight.bold
                  ),)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _favTagsWidget() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: 300,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: CurrentTheme.backgroundContrast,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: CurrentTheme.shadow2, spreadRadius: 10, blurRadius: 10)
              ]),
          child: Wrap(
            children: _favTagsList(),
          ),
        )
      ],
    );
  }
  _favTagsList() {
    var userFavTagsList = new List<Widget>();
    var testTags = [
      "fantasy",
      "adventure",
      "romance",
      "mystery",
      "horror",
      "art",
      "history",
      "development",
      "academic",
      "motivational",
    ];
    for (int i = 0; i < 10; i++) {
      userFavTagsList.add(Tag(testTags[i]));
      userFavTagsList.add(SizedBox(width: 10, height: 40));
    }
    return userFavTagsList;
  }
}

class Clip3 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, (size.height - size.height/3) - 80);

    var firstControlpoint = Offset(size.width/4+20, (size.height - size.height/3) - 100);
    var firstEndPoint = Offset(size.width/2, size.height - size.height/4);

    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width -(size.width/4), size.height);
    var secondEndPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Tag extends StatefulWidget{
  String name;
  Tag(this.name);
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag>{
  bool selected;
  @override void initState() {
    selected = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!selected) ConfigCache.tags.add(widget.name);
        else ConfigCache.tags.remove(widget.name);
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
        height: 33,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: selected ? CurrentTheme.primaryColorVariant : CurrentTheme.backgroundContrast,
            border: Border.all(color: CurrentTheme.primaryColorVariant),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          widget.name,
          style: TextStyle(color: CurrentTheme.textColor2, fontSize: 13),
        ),
      ),
    );
  }

}