import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/ML_kit.dart';

String newTag() => ML.getRecommendedTags(1)[0];

class Tag extends StatefulWidget{
  String name;
  Tag(this.name);
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag>{
  bool show;

  @override void initState() {
    show = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          show = false;
        });

        MainUser.addTag(widget.name);

        widget.name = newTag();

        setState(() {
          show = true;
        });
      },
      child: AnimatedContainer(
        curve: Curves.elasticInOut,
        height: show? 33 : 11,
        padding: show? EdgeInsets.all(8.0) : EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            color: show? CurrentTheme.backgroundContrast : CurrentTheme.background,
            border: Border.all(color: CurrentTheme.primaryColorVariant),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        duration: Duration(milliseconds: 2000),
        child: show?
          Text(widget.name, style: TextStyle(color: CurrentTheme.textColor2, fontSize: 13)) : Container(),
      ),
    );
  }
}



class TagCloud extends StatefulWidget {
  @override
  _TagCloudState createState() => _TagCloudState();
}

class _TagCloudState extends State<TagCloud> with SingleTickerProviderStateMixin {
  List<Widget> _theTags;
  bool _transition;



  @override
  _TagCloudState() {
    _theTags = _tagList();
    _transition = false;
  }

  _tagList() {
    var newTags = ML.getRecommendedTags(10);
    var tagsList = new List<Widget>();
    for (int i = 0; i < 10; i++) {
      tagsList.add(Tag(newTags[i]));
      tagsList.add(SizedBox(width: 10, height: 40));
    }
    return tagsList;
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: CurrentTheme.shadow2, spreadRadius: 5, blurRadius: 10)
          ]
      ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 300,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: CurrentTheme.backgroundContrast,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            child: Wrap(
              children: _theTags,
            ),
          ),
          Positioned(
              top: -15.0,
              right: -15.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new IconButton(
                    icon: Icon(Icons.refresh, color: CurrentTheme.primaryColor),
                    onPressed: () {
                      setState(() {
                        _transition = true;
                        _theTags = _tagList();
                        _transition = false;
                      });
                    }),
              )
          ),
          AnimatedSize(
              vsync: this,
              duration: Duration(seconds: 2),
              child: Container(
                //duration: Duration(seconds: 2),
                //curve: Curves.elasticInOut,
                alignment: Alignment.centerLeft,
                width: _transition? 300 : 0,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: _transition? CurrentTheme.separatorColor : Color.fromARGB(0, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          ))
        ]
      ),
    );
  }
}
