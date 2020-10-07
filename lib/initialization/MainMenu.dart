import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'coming_soon_scaffold.dart';
import 'search_scaffold.dart';
import 'mainPage_scaffold.dart';
import 'user_profile_scaffold.dart';

class Menu extends StatefulWidget {
  final int number;
  Menu(this.number);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  PageController pageControl = PageController();
  int numbpage = 0;
  void changePage(int a) {
    setState(() {
      numbpage = a;
    });
  }

  void onTapped(int a) {
    pageControl.jumpToPage(a);
  }

  @override
  void initState() {
    super.initState();
    numbpage = widget.number;
    pageControl = PageController(initialPage: numbpage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: <Widget>[
          CommingSoonPage(),
          SearchScaffold(),
          MainPage(),
          CommingSoonPage(),
          UserProfileScaffold(),
        ],
        controller: pageControl,
        onPageChanged: changePage,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(
            Icons.group,
            color: numbpage == 0 ? Colors.white : Colors.deepOrange[400],
            size: 30,
          ),
          Icon(
            Icons.search,
            color: numbpage == 1 ? Colors.white : Colors.deepOrange[400],
            size: 30,
          ),
          Icon(
            Icons.home,
            color: numbpage == 2 ? Colors.white : Colors.deepOrange[400],
            size: 30,
          ),
          Icon(
            Icons.format_list_bulleted,
            color: numbpage == 3 ? Colors.white : Colors.deepOrange[400],
            size: 30,
          ),
          Icon(
            Icons.person,
            color: numbpage == 4 ? Colors.white : Colors.deepOrange[400],
            size: 30,
          ),
        ],
        color: Colors.white,
        backgroundColor: Colors.grey[50],
        buttonBackgroundColor: Colors.deepOrange,
        onTap: onTapped,
        index: numbpage,
        animationDuration: Duration(milliseconds: 250),
        height: 60,
      ),
    );
  }
}
