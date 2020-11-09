import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
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
    return FutureBuilder(
      future: user.setUser(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Center(child: Text(
                  'hello' + user.user.name
              ),)
          );
        }

        return Scaffold(
          body: Center(
            child: Text(
              'We are loading we'
            ),
          ),
        );
      }
    );
  }
}
