
import 'package:buku/main_objects/author.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';

class MiniAuthor {
  ///Attributes
  String _name, _imageURL;

  ///Getters
  String get name => _name;
  String get imageURL => _imageURL;

  ///Constructor
  MiniAuthor(this._name, this._imageURL);

  Widget toWidget(BuildContext context){
    return GestureDetector(
      onTap: ()  async {
        /*Author author = await Firestore().getAuthor(this._name);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthorInfoScaffold(Author: author)),
        );*/
      },
      child: Container(
        height: 115, width: 105,
        padding: EdgeInsets.only(
          top:10, bottom: 10,
          left: 5,right: 5
        ),
        decoration: BoxDecoration(
          //border: Border.all(color: CurrentTheme.separatorColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: CurrentTheme.backgroundContrast
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(this._imageURL),
                      fit: BoxFit.fill)),
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text(this._name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: CurrentTheme.textColor2,
                  )),
            )
          ],
        ),
      ),
    );
  }
}