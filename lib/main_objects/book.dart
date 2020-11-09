
import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/material.dart';

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
  Book(this._title, this._language, this._year, this._publisher, this._synopsis, this._imageURL, this._views, this._pages, this._rating,
      List<dynamic> authors, List<dynamic> tags, List<BookComment> comments, List<dynamic> pdfLinks,
      Map<String, dynamic> buyURL, Map<String, dynamic> isbn){
    this._authors = authors;
    this._tags = tags;
    this._comments = comments;
    this._pdfLinks = pdfLinks;
    this._buyURL = buyURL;
    this._isbn = isbn;
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


  Widget bookStatistics(){
    double rat = double.parse(_rating.toStringAsFixed(1));
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _ratingStars(rat),
              Text(rat.toString())
            ],
          ),
          SizedBox(width: 25),

          Container(
            height: 20,
            width: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color:CurrentTheme.separatorColor,
            ),
          ),

          SizedBox(width: 25),

          Column(
            children: [
              Icon(Icons.visibility,
                  color: CurrentTheme.primaryColor,
                  size:20.0),
              Text(FormatString.formatStatistic(this._views) + 'views')
            ],
          )
        ]);
  }

  /*String _formatViews(){
    int len = this._views.toString().length;
    String text;
    if (len<=3){
      text = this._views.toString();
    } else if (len <=6){
      text = (this._views/1000).toStringAsFixed(1)+"K";
    } else {
      text = (this._views/1000000).toStringAsFixed(1)+"M";
    }
    text = text + " views";
    return text;
  }*/

  Widget _ratingStars(double rating){
    double rat = rating;
    List<Widget> ratingStars = List<Widget>(5);
    for(int i = 0; i<5;i++){
      if(rat>=1){
        ratingStars[i] = Icon(Icons.star,
            color: CurrentTheme.primaryColor,
            size:15.0);
      } else if (rat>0){
        ratingStars[i] = Icon(Icons.star_half,
            color: CurrentTheme.primaryColor,
            size:15.0);
        rat = 0;
      } else if (rat<=0){
        ratingStars[i] = Icon(Icons.star_border,
            color: CurrentTheme.primaryColor,
            size:15.0);
      }
      rat--;
    }
    return Row(children: ratingStars);
  }

  Widget bookInfo(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text("Book info",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),),
        SizedBox(height: 10),
        Container(
          child: Column(
            children: [
              _infoText("Year: ",this._year),
              SizedBox(height: 10),
              _infoText("Publisher: ",this._publisher),
              SizedBox(height: 10),
              _infoText("Pages: ",this._pages.toString()),
              SizedBox(height: 10),
              _infoText("Language: ",this._language),
              SizedBox(height: 10),
              _infoText("ISBN-10: ",this._isbn["isbn_10"]),
              SizedBox(height: 10),
              _infoText("ISBN-13: ",this._isbn["isbn_13"]),
              SizedBox(height: 10),
              //TODO: display tags.
            ],
          ),
        )
      ],
    );
  }

  Widget _infoText(String item, String value){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(TextSpan(
          children: [
            TextSpan(text: item, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value)
          ])),
    );
  }

  Widget bookImage({double width: 175.0}){
    return Container(
        height: width*1.6,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(this._imageURL),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: CurrentTheme.shadow1,
                  spreadRadius: 5,
                  blurRadius: 20
              )]
        )
    );
  }

}