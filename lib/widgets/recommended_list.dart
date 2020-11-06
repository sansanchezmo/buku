import 'package:buku/main_objects/book.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatefulWidget{
  List<Book> list;

  RecommendedList({Key key, @required this.list}) : super(key : key);
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 140,
      //color: Colors.red,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: Opacity(
              opacity: 0.5,
              child: getbookImage(2),
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: Opacity(
              opacity: 0.8,
              child: getbookImage(1),
            ),
          ),
          getbookImage(0),
        ],
      ),
    );
  }

  getbookImage(int i){
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage( //TODO: fix recommended list an recommended list widget
            /*image: NetworkImage(widget.list[i].getImageL()), fit: BoxFit.fill*/),
      ),
    );
  }

}