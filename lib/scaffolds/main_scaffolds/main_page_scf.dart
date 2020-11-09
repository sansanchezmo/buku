import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/structs/linked_list.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buku/database/database.dart';
import 'package:buku/main_objects/structs/queue.dart';
import 'package:buku/main_objects/structs/stack.dart';
import 'package:buku/main_objects/structs/vector.dart';
import 'package:buku/scaffolds/others_scaffolds/tag_cloud_scf.dart';

class MainPageScaffold extends StatefulWidget {
  _MainPageScaffoldState createState() => _MainPageScaffoldState();
}

class _MainPageScaffoldState extends State<MainPageScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Test',
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CurrentTheme.primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: CurrentTheme.primaryColor,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.timeline),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/testpages');
                          print('You pressed the icon.');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Recommendation',
                style: TextStyle(
                  color: CurrentTheme.textColor1,
                  fontFamily: 'ProductSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Find trending and popular books among your pleasures.',
                  style: TextStyle(
                    color: CurrentTheme.textColor1,
                    fontFamily: 'ProductSans',
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 30),
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 30),
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 30),
              Image(
                image: AssetImage(
                  'assets/images/open-book.png',
                ),
                width: 150.0,
                height: 150.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
