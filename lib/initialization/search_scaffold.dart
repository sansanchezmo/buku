import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* TODO:
- Search method.
- List view.
- Result pages Array.
- Filters.
 */

class SearchScaffold extends StatefulWidget{
  @override
  _SearchScaffold createState() => _SearchScaffold();

}

class _SearchScaffold extends State<SearchScaffold>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: 210,
              width: double.infinity,
              padding: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)
                ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 10
                    )
                  ],
                gradient: LinearGradient(
                    colors: [Colors.orange,Colors.deepOrange]
                )
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                          Icon(Icons.navigate_before,
                            color: Colors.white70,
                            size: 30),
                          SizedBox(width:10),
                          _searchBar(),
                          SizedBox(width: 20),
                      ]),
                  ])),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
          )
        ],
      ),
    );
  }

  _searchBar(){
    return Container(
      height: 45,
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(30)),

      ),
      child: Row(
        children: [
          SizedBox(width: 15,),
          Icon(
            Icons.search,
            color: Colors.black12,
            size: 30
          ),
          SizedBox(width: 10,),
          Flexible(
            child: TextField(
              cursorColor: Colors.black38,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Here",
                hintStyle: TextStyle(
                  color: Colors.black38
                )
              )
              //onChanged: (text) {}, //Here goes the search method.
            ),
          ),
          SizedBox(width: 30,)
        ],
      ),
    );
  }

}