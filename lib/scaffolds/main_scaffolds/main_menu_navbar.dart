import 'package:buku/scaffolds/others_scaffolds/testdata_primitive_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/search_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../others_scaffolds/comming_soon_scf.dart';
import 'main_page_scf.dart';
import 'user_profile_scf.dart';

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
      body: PageView(
        children: <Widget>[
          ComingSoonScaffold(),
          SearchScaffold(),
          MainPageScaffold(),
          ComingSoonScaffold(),
          UserProfileScaffold(),
        ],
        controller: pageControl,
        onPageChanged: changePage,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(
            Icons.group,
            color: numbpage == 0
                ? CurrentTheme.navigatorBarColor
                : CurrentTheme.primaryColor,
            size: 30,
          ),
          Icon(
            Icons.search,
            color: numbpage == 1
                ? CurrentTheme.navigatorBarColor
                : CurrentTheme.primaryColor,
            size: 30,
          ),
          Icon(
            Icons.library_books,
            color: numbpage == 2
                ? CurrentTheme.navigatorBarColor
                : CurrentTheme.primaryColor,
            size: 30,
          ),
          Icon(
            Icons.format_list_bulleted,
            color: numbpage == 3
                ? CurrentTheme.navigatorBarColor
                : CurrentTheme.primaryColor,
            size: 30,
          ),
          Icon(
            Icons.person,
            color: numbpage == 4
                ? CurrentTheme.navigatorBarColor
                : CurrentTheme.primaryColor,
            size: 30,
          ),
        ],
        color: CurrentTheme.navigatorBarColor,
        backgroundColor: CurrentTheme.background,
        buttonBackgroundColor: CurrentTheme.primaryColor,
        onTap: onTapped,
        index: numbpage,
        animationDuration: Duration(milliseconds: 250),
        height: 60,
      ),
    );
  }
}
