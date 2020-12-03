
import 'package:buku/main_objects/author.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiniAuthor {
  ///Attributes
  String _name, _imageURL;
  int _books, _followers;
  //Map<String,dynamic> _statistics = {"books":20,"followers":140};

  ///Getters
  String get name => _name;
  String get imageURL => _imageURL;
  int get booksCount => _books;
  int get followers => _followers;

  ///Constructor
  MiniAuthor(this._name, this._imageURL, this._books, this._followers);


  Widget toWidget(BuildContext context){
    /**
     * Returns the widget used in the horizontal scroll.
     */
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
                      image: this._imageURL == null? AssetImage('assets/images/user_notFound.png') : NetworkImage(this._imageURL),
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

  Widget toResultWidget(){
    print("1");
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55, width: 55,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/user.png')
              ),
              shape: BoxShape.circle
            ),
          ),
          SizedBox(width: 25),
          Column(
            children: [
              Container(
                width: 230,
                child: Text(this.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: CurrentTheme.textColor1,fontSize: 16)),
              ),
              Container(
                width: 230,
                child: Text(booksCount.toString() + " Books - " + FormatString.formatStatistic(followers) +" Followers",
                    style: TextStyle(color: CurrentTheme.textColor3,fontSize: 14.5)),
              ),
            ],
          )
        ],
      ),
    );
  }


}