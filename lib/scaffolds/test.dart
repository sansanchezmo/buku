import 'package:buku/firebase/ML_kit.dart';
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/widgets/gradient_button.dart';
import 'package:buku/widgets/recommended_list.dart';
import 'package:buku/widgets/recommended_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'init_scaffolds/config_widgets/interesting_tags.dart';

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  MainUser user = MainUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GradientButton(
          text: 'hola',
          tap: () async{
            await MainUser.init();
            await ML.init();
            var list = await ML.getRecommendedBooks(10);
            for(MiniBook mini in list){
              print(mini.title);
            }
        },
        ),
      ),
    );
  }

}
