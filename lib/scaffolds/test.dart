import 'package:buku/firebase/ML_kit.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/tag.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/search_engine/search.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/gradient_button.dart';
import 'package:buku/widgets/recommended_list.dart';
import 'package:buku/widgets/recommended_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  MainUser user = MainUser();
  TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: con,
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'ProductSans',
                    color: CurrentTheme.textFieldHint,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CurrentTheme.textColor1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: CurrentTheme.primaryColor))),
            ),
            SizedBox(height: 50,),
            GradientButton(
              text: 'search',
              tap: () async {
                //print(ML.searchISBN(con.text));
                /*print('isbn');
                print(Search.searchISBN(con.text));
                print('author');
                print(Search.searchTitle(con.text));*/
                print('author');
                var list = await Search.search(con.text);
                print(list.length.toString());
                print(list);
                /*for (var i in list){
                  print(i.text);
                }*/
                /*for(var e in list){
                  if(e is MiniBook) print(e.title);
                  if(e is MiniAuthor) print(e.name);
                  if(e is Tag) print(e.text);
                }*/

              },
            ),
            SizedBox(height: 30,),
            GradientButton(
              text: 'initialize',
              tap: () async{
                await Search.init();
                await ML.init();

              },
            ),
          ],
        ),
      ),
    );
  }

}
