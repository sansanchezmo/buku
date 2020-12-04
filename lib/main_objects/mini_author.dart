
import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/author.dart';
import 'package:buku/scaffolds/others_scaffolds/author_info_scf.dart';
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
      onTap: ()  async{
      Author bigAuthor = await Firestore().getAuthor(_name);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthorInfoScaffold(bigAuthor)),
      );
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
              child: Text(this._name == null? "null": this._name,
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
          Stack(alignment: Alignment.center, children: [
            Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      //fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/user.png"),
                    ))),
            this._imageURL != "null"? Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                      NetworkImage(this._imageURL),
                    ))) : Container()
          ]),
          /*Container(
            height: 55, width: 55,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/user.png')
              ),
              shape: BoxShape.circle
            ),
          ),*/
          SizedBox(width: 25),
          Column(
            children: [
              Container(
                width: 230,
                child: Text(this._name == null? "null": this._name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: CurrentTheme.textColor1,fontSize: 16)),
              ),
              Container(
                width: 230,
                child: Text(_books.toString() + " Books - " + FormatString.formatStatistic(_followers) +" Followers",
                    style: TextStyle(color: CurrentTheme.textColor3,fontSize: 14.5)),
              ),
            ],
          )
        ],
      ),
    );
  }


}