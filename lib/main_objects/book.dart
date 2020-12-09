import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/scaffolds/others_scaffolds/author_info_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as FS;

import 'author.dart';
import 'main_user.dart';
import 'mini_book.dart';

/**
 * This class contains the complete info of a book. The null attributes are stored as a string 'null'.
 * Some list are managed as dynamic values.
 */
class Book {
  ///Instance attributes
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
  List<dynamic> _pdfLinks;
  Map<String, dynamic> _buyURL;
  Map<String, dynamic> _isbn;

  ///Constructor
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
      List<dynamic> pdfLinks,
      Map<String, dynamic> buyURL,
      Map<String, dynamic> isbn,
      {userInitialize: true}) {
    this._authors = authors;
    this._tags = tags;
    this._pdfLinks = pdfLinks;
    this._buyURL = buyURL;
    this._isbn = isbn;
    if(userInitialize){
      updateViews();
      addToHistory();
    }
  }

  ///Getters
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
  List<dynamic> get pdfLinks => _pdfLinks;
  Map<String, dynamic> get buyURL => _buyURL;
  Map<String, dynamic> get isbn => _isbn;

  ///---------------------------- Book methods -------------------------------

  void updateViews() async {
    /**
     * Increments the views by 1 each time a user get into the info scaffold.
     */
    await Firestore().updateBookViews(isbn['isbn_10']);
  }

  void addToHistory() async {
    MiniBook mini = toMiniBook();
    await MainUser.addToOpenHistory(mini);
  }

  Future<void> rate(double stars) async {
    /**
     * updates the book rating when a user gives his rate.
     */
    double currentStars = MainUser.currentBookRate(isbn['isbn_10']);
    await Firestore().rateBook(isbn['isbn_10'], stars, currentStars);
    await MainUser.rateBook(isbn['isbn_10'], stars);
  }

  Future<void> commentBook(BookComment comment) async {
    /**
     * Updates the book comments section.
     */
    await Firestore().addComment(isbn['isbn_10'], comment);
  }

  Future<void> addToFavorites() async {
    /**
     * Adds the book to the user's fav list.
     */
    MiniBook mini = toMiniBook();
    await MainUser.addBookToFavorites(mini);
  }

  Future<void> removeFromFavorites() async {
    /**
     * Removes the book from the user's fav list.
     */
    await MainUser.removeBookFromFavorites(isbn['isbn_10']);
  }

  Stream getComments(){
    return Firestore().getBookCommentBuilder(isbn['isbn_10']);
  }

  MiniBook toMiniBook() {
    /**
     * Returns the MiniBook version of the book.
     * class: MiniBook.
     */
    List<dynamic> authorList = [];

    for (MiniAuthor miniAuthor in authors) {
      authorList.add(miniAuthor.name);
    }

    return MiniBook(_isbn['isbn_10'], _title, authorList, _imageURL);
  }

  /// ----------------------- widget methods ---------------------------

  // ignore: missing_return
  List<Widget> authorWidgetList(BuildContext context) {
    /**
     * Returns the author list as a widget to display at the book info scaffold.
     */
    List<Widget> authorList = new List<Widget>();
    for (MiniAuthor author in this.authors) {
      authorList.add(GestureDetector(
        onTap: () async{
          Author bigAuthor = await Firestore().getAuthor(author.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AuthorInfoScaffold(bigAuthor)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: CurrentTheme.backgroundContrast,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: author.imageURL == null
                              ? AssetImage('assets/images/user_notFound.png')
                              : NetworkImage(author.imageURL),
                          fit: BoxFit.fill))),
              SizedBox(width: 15),
              Container(
                width: 130,
                child: Text(
                  author.name,
                  style: TextStyle(
                      color: CurrentTheme.textColor1,
                      fontWeight: FontWeight.w200,
                      fontSize: 14.5),
                ),
              )
            ],
          ),
        ),
      ));
      return authorList;
    }
  }

  Widget ratingStars(double rating) {
    /**
     * Returns the stars icons in a row, depending on the book´s rating.
     */
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
    /**
     * Returns the book image as a container.
     * params: width (default: 175) -> It get que height according to the proportion
     * 1:1.6
     */
    return Stack(children: [
      Container(
        height: width * 1.6,
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: CurrentTheme.backgroundContrast,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: CurrentTheme.shadow2, spreadRadius: 5, blurRadius: 15)
            ]),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              this.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: CurrentTheme.textColor3),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(child: SizedBox()),
            Text(
              _authorNames(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: CurrentTheme.textColor3),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
      Container(
        height: width * 1.6,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(this.imageURL))),
      )
    ]);
  }

  String _authorNames(){
    MiniAuthor auth = this._authors[0];
    String names = auth.name;
    for(int i = 1; i<this._authors.length; i++){
      auth = this._authors[i];
      names = names + ", " + auth.name;
    }
    return names;
  }

  List<Widget> tagWidgetList() {
    List<Widget> tagList = new List<Widget>();
    for (String tag in tags) {
      tagList.add(FlatButton(
        textColor: CurrentTheme.textColor3,
        onPressed: () {
          //TODO: go to tag method.
        },
        child: Container(
          height: 25,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: CurrentTheme.backgroundContrast,
              border: Border.all(color: CurrentTheme.primaryColorVariant),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            tag,
            style: TextStyle(color: CurrentTheme.textColor3, fontSize: 14.5),
          ),
        ),
      ));
      return tagList;
    }
  }

  Widget commentWidgetList() {
    /*List<Widget> commentsList = new List<Widget>();
    for (BookComment comment in _comments) {
      commentsList.add(comment.toWidget());
    }
    return commentsList;*/
    return StreamBuilder(
      stream: getComments(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Text('Please Wait')
            : ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            FS.DocumentSnapshot commentSnap = snapshot.data.documents[index];
            BookComment comment = BookComment(commentSnap['user_uid'],
                commentSnap['user_name'], commentSnap['user_nickname'],
                commentSnap['user_image'], commentSnap['comment'],
                commentSnap['date']);
            return comment.toWidget();
          }
        );
      },
    );
  }
}
