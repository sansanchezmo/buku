import 'dart:math';

import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/read_list.dart';
import 'package:buku/theme/colors_list.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatefulWidget{
  ReadList list;


  RecommendedList({Key key, @required this.list}) : super(key : key);
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList>{
  int iColor = 0;
  List<Color> colors = ColorsList.colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Container(
              height: 180,
              width: 140,
              //color: Colors.red,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: getDefaultImage(),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: getBookImage(2),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: getDefaultImage(),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: getBookImage(1),
                ),
                getDefaultImage(),
                getBookImage(0),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            widget.list.name,
            style: TextStyle(
              color: CurrentTheme.textColor1,
              fontSize: 15
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
          )
        ]
      ),
    );
  }

  getBookImage(int i){
    if(i>=widget.list.bookList.length){
      i = 0;
    }
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: NetworkImage(widget.list.bookList[i].imageURL), fit: BoxFit.fill),
      ),
    );
  }

  getDefaultImage(){
    iColor = (iColor + 1)%5;
    return Container(
      height: 140,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: colors[iColor],
      ),
      child: Container(
        height: 40,
        width: 40,
    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.scaleDown,
    image: AssetImage("assets/images/book_icon.png")
    )
      ),
    ));
  }

}