import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/config_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                decoration: BoxDecoration(
                  gradient: CurrentTheme.primaryGradientColor
                ),
              ),
            ),
            Positioned(
                top: 140, left: 20,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          'Choose your interests',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          'Select some tags to start exploring',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
            Positioned(
              bottom: 200,
              child: _favTagsWidget(),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: CurrentTheme.primaryColorVariant,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [BoxShadow(
                    color: CurrentTheme.shadow2,
                    spreadRadius: 2,
                    blurRadius: 5
                  )]
                ),
                child: RaisedButton(
                  onPressed: () async {
                    ConfigCache.name = widget.name.text;
                    ConfigCache.description = widget.desc.text;

                    if(ConfigCache.nameEmpty()) ConfigCache.name = await MainUser.getNickName() ;
                    if(ConfigCache.descriptionEmpty()) ConfigCache.description = 'Hi there! I´m using Buku';

                    await ConfigCache.storeCache();

                    Navigator.of(context).pushNamed('/menu');
                  },
                  elevation: 0,
                  color: Colors.transparent,
                  child: Text("Let's go!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),),
                ),
              )

            )
          ],
        ),
      ),
    );
  }
  _favTagsWidget() {
    return Container(
      alignment: Alignment.center,
      width: 300,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: CurrentTheme.backgroundContrast,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: CurrentTheme.shadow2,
                spreadRadius: 2,
                blurRadius: 10,
              offset: Offset(5,5)
            )
          ]),
      child: Wrap(
        children: _favTagsList(),
      ),
    );
  }
  _favTagsList() { //TODO: change tags
    var userFavTagsList = new List<Widget>();
    var testTags = [
      "Fantasy",
      "Adventure",
      "Romance",
      "Mystery",
      "Horror",
      "Art",
      "History",
      "Development",
      "Academic",
      "Motivational",
    ];
    for (int i = 0; i < testTags.length; i++) {
      userFavTagsList.add(Tag(testTags[i]));
      i != testTags.length -1? userFavTagsList.add(SizedBox(width: 10, height: 40)) : 0;
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