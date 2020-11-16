import 'package:buku/main_objects/structs/stack.dart';
import 'package:buku/main_objects/read_list.dart';
import 'package:buku/widgets/recommended_list.dart';
import 'package:flutter/cupertino.dart';

class RecommendedListWidget extends StatefulWidget{

  ListStack<ReadList> stack;

  RecommendedListWidget(this.stack);

  _RecommendedListWidgetState createState() => _RecommendedListWidgetState();
}

class _RecommendedListWidgetState extends State<RecommendedListWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RecommendedList(list: widget.stack.pop()),
              SizedBox(width: 30,),
              RecommendedList(list: widget.stack.pop()),
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RecommendedList(list: widget.stack.pop()),
              SizedBox(width: 30,),
              RecommendedList(list: widget.stack.pop()),
            ],
          )
        ],
      ),
    );
  }

}