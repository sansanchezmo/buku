import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/config_cache.dart';
import 'package:flutter/cupertino.dart';

class BookImageHorizontalSlider extends StatefulWidget{

  _BookImageHorizontalSlider createState() => _BookImageHorizontalSlider();

}

class _BookImageHorizontalSlider extends State<BookImageHorizontalSlider>{
  String selectedBook;
  @override
  void initState() {
    selectedBook = '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> userFavBooks = List<Widget>();
    for (int i = 0; i < MainUser.favBooks.length; i++) {
      MiniBook book = MainUser.favBooks[i];
      userFavBooks.add(Container(
        height: 164,
        color: book.isbn10 == selectedBook? CurrentTheme.primaryColor
            : CurrentTheme.backgroundContrast,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: (){
            String selected;
            if(selectedBook == book.isbn10) {
              ConfigCache.forumSelectedMiniBook = null;
              selected = '';
            }
            else {
              ConfigCache.forumSelectedMiniBook = book;
              selected = book.isbn10;
            }
            setState(() {
              selectedBook = selected;
            });
          },
          child: book.miniBookImage(),
        ),
      ));
    }
    return Container(
      height: 164,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: userFavBooks,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

}