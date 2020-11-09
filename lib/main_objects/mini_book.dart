
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/scaffolds/others_scaffolds/book_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';

class MiniBook{
  //Instance attributes
  String _isbn10;
  String _title;
  List<dynamic> _authors;
  String _imageURL;

  //Constructor
  MiniBook(this._isbn10, this._title, this._authors, this._imageURL);

  //Getters
  String get isbn10 => _isbn10;
  String get title => _title;
  List<String> get authors => _authors;
  String get imageURL => _imageURL;

  Widget toWidget(BuildContext context){
    String authorsStr = _authorNames();
    return GestureDetector(
      onTap: () async {
        Book book = await Firestore().getBook(this._isbn10);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: 110,
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            //Book's image container
            miniBookImage(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: CurrentTheme.textColor3,
                      )),
                  SizedBox(height: 5),
                  //Book's author
                  Text(authorsStr,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 11,
                        color: CurrentTheme.textColor2,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget miniBookImage({double width: 90}){
    return Container(
      height: width*1.6, width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: NetworkImage(this._imageURL), fit: BoxFit.fill),
      ),
    );
  }

  String _authorNames(){
    String names = this._authors[0];
    for(int i = 1; i<this._authors.length; i++){
      names = names + ", " + this._authors[i];
    }
    return names;
  }
}