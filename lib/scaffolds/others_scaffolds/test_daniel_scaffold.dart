import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDanielScaffold extends StatefulWidget{

  @override
  _TestDanielScaffoldState createState() => _TestDanielScaffoldState();

}

class _TestDanielScaffoldState extends State<TestDanielScaffold>{
  @override
  Widget build(BuildContext context) {
    MiniUser user1 = new MiniUser("", "Nombre Real más largo de todos quesdfaf contiene mucho texto para mirar el textoverflow", "_nickname", "assets/user_images/user_1.png");
    MiniUser user2 = new MiniUser("", "Andrés Sierrs", "_nickname2", "assets/user_images/user_3.png");
    MiniUser user3 = new MiniUser("", "Camila Andrea", "_nickname3", "assets/user_images/user_4.png");
    MiniUser user4 = new MiniUser("", "Kevin de la Torre", "_nickname4", "assets/user_images/user_2.png");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120),
            user1.toWidget(context),
            user2.toWidget(context),
            user3.toWidget(context),
            user4.toWidget(context),
            /*Container(
              height: 25, width: 25,
              decoration: BoxDecoration(
                color: CurrentTheme.backgroundContrast,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: author.imageURL == null? AssetImage('assets/images/user_notFound.png') : NetworkImage(author.imageURL),
                  fit: BoxFit.fill
                )
              )
            ),*/
          ],
        ),
      ),
    );
 }

}