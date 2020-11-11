import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_user.dart';
import 'mini_book.dart';

class Book {
  //Instance attributes
  final String _title;
  final String _language;
  final String _year;
  final String _publisher;
  final String _synopsis;
  final String _imageURL;
  final int _views;
  final int _pages;
  final double _rating;
  List<dynamic> _authors;
  List<dynamic> _tags;
  List<BookComment> _comments;
  List<dynamic> _pdfLinks;
  Map<String, dynamic> _buyURL;
  Map<String, dynamic> _isbn;

  //Constructor
  Book(
      this._title,
      this._language,
      this._year,
      this._publisher,
      this._synopsis,
      this._imageURL,
      this._views,
      this._pages,
      this._rating,
      List<dynamic> authors,
      List<dynamic> tags,
      List<BookComment> comments,
      List<dynamic> pdfLinks,
      Map<String, dynamic> buyURL,
      Map<String, dynamic> isbn) {
    this._authors = authors;
    this._tags = tags;
    this._comments = comments;
    this._pdfLinks = pdfLinks;
    this._buyURL = buyURL;
    this._isbn = isbn;
    updateViews();
    addToHistory();
  }

  //Getters
  String get title => _title;
  String get language => _language;
  String get year => _year;
  String get publisher => _publisher;
  String get synopsis => _synopsis;
  String get imageURL => _imageURL;
  int get views => _views;
  int get pages => _pages;
  double get rating => _rating;
  List<dynamic> get authors => _authors;
  List<dynamic> get tags => _tags;
  List<dynamic> get comments => _comments;
  List<dynamic> get pdfLinks => _pdfLinks;
  Map<String, dynamic> get buyURL => _buyURL;
  Map<String, dynamic> get isbn => _isbn;

  //Book methods

  void updateViews() async{
    await Firestore().updateBookViews(isbn['isbn_10']);
  }
  void addToHistory() async{
    MiniBook mini = toMiniBook();
    await MainUser.addToOpenHistory(mini);
  }

  Future<void> rate(double stars) async{
    double currentStars = MainUser.currentBookRate(isbn['isbn_10']);
    await Firestore().rateBook(isbn['isbn_10'], stars, currentStars);
    await MainUser.rateBook(isbn['isbn_10'], stars);
  }

  Future<void> commentBook(BookComment comment) async{
    await Firestore().addComment(isbn['isbn_10'], comment);
  }

  Future<void> addToFavorites() async{
    MiniBook mini = toMiniBook();
    await MainUser.addBookToFavorites(mini);
  }

  Future<void> removeFromFavorites() async{
    await MainUser.removeBookFromFavorites(isbn['isbn_10']);
  }

  MiniBook toMiniBook(){

    List<dynamic> authorList = [];

    for(MiniAuthor miniAuthor in authors){
      authorList.add(miniAuthor.name);
    }

    return MiniBook(
      _isbn['isbn_10'],
      _title,
      authorList,
      _imageURL
    );
  }

  // widget methods
  
  List<Widget> authorWidgetList(){
    List<Widget> authorList = new List<Widget>();
    for(MiniAuthor author in this.authors){
      authorList.add(
        Padding(
          padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 25, width: 25,
                decoration: BoxDecoration(
                  color: CurrentTheme.backgroundContrast,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: author.imageURL == null? AssetImage('assets/images/user_notFound.png') : NetworkImage(author.imageURL),
                    fit: BoxFit.fill
                  )
                )
              ),
              SizedBox(width: 15),
              Container(width: 130,
                child: Text(author.name,
                style: TextStyle(
                  color: CurrentTheme.textColor1,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.5
                ),),
              )
            ],
          ),
        )
      );
      return authorList;
    }
  }

  Widget ratingStars(double rating) {
    double rat = rating;
    List<Widget> ratingStars = List<Widget>(5);
    for (int i = 0; i < 5; i++) {
      if (rat >= 1) {
        ratingStars[i] =
            Icon(Icons.star, color: CurrentTheme.primaryColor, size: 15.0);
      } else if (rat > 0) {
        ratingStars[i] =
            Icon(Icons.star_half, color: CurrentTheme.primaryColor, size: 15.0);
        rat = 0;
      } else if (rat <= 0) {
        ratingStars[i] = Icon(Icons.star_border,
            color: CurrentTheme.primaryColor, size: 15.0);
      }
      rat--;
    }
    return Row(children: ratingStars);
  }

  Widget bookImage({double width: 175.0}) {
    return Stack(
      children: [
        Container(
          height: width * 1.6,
          width: width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: CurrentTheme.backgroundContrast,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: CurrentTheme.shadow2, spreadRadius: 5, blurRadius: 20)
              ]),
          child: Text(this.title, style: TextStyle(fontSize: 20, color: CurrentTheme.textColor3), maxLines: 2, overflow: TextOverflow.ellipsis,),
        ),
        Container(
          height: width * 1.6,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    this.imageURL
                  )
              )
          ),
        )
      ]
    );
  }

  List<Widget> tagWidgetList(){
    List<Widget> tagList = new List<Widget>();
    for(String tag in tags){
      tagList.add(
        FlatButton(
          textColor: CurrentTheme.textColor3,
          onPressed: (){
            //TODO: go to tag method.
          },
          child: Container(
            height: 25,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
                color: CurrentTheme.backgroundContrast,
                border: Border.all(color: CurrentTheme.primaryColorVariant),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              tag,
              style: TextStyle(color: CurrentTheme.textColor3, fontSize: 14.5),
            ),
          ),
        )
      );
      return tagList;
    }
  }

  List<Widget> commentWidgetList(){
    List<Widget> commentsList = new List<Widget>();
    for(BookComment comment in _comments){
      commentsList.add(comment.toWidget());
    }
    return commentsList;
  }
}
