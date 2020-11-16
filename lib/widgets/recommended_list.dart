import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/read_list.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatefulWidget{
  ReadList list;

  RecommendedList({Key key, @required this.list}) : super(key : key);
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList>{
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
                alignment: Alignment.topLeft,
                children: [
                Positioned(
                  top: 30,
                  left: 30,
                  child: Opacity(
                    opacity: 0.5,
                    child: getDefaultImage(),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: Opacity(
                    opacity: 0.5,
                    child: getBookImage(2),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Opacity(
                    opacity: 0.8,
                    child: getDefaultImage(),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Opacity(
                    opacity: 0.8,
                    child: getBookImage(1),
                  ),
                ),
                getDefaultImage(),
                getBookImage(0),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    widget.list.name,
                    style: TextStyle(
                      color: CurrentTheme.textColor1
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              )
            ],
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
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        //color: CurrentTheme.primaryColor,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            'https://i.pinimg.com/originals/0a/b8/c0/0ab8c02e99cad89b1f602c00ad65c121.jpg'
          )
        )
      )
    );
  }

}