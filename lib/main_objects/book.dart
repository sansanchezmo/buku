import 'dart:math';

class Book{
  //Instance attributes
  final String _isbn, _title, _author, _year, _publisher, _synopsis;
  final String _imageURL;
  double _rating;

  //Constructor
  Book(this._isbn, this._title, this._author, this._year, this._publisher, this._synopsis, this._imageURL) {
    scanBookRating();
  }

  scanBookRating(){
    var rdm = new Random();
    _rating = rdm.nextInt(50)/10; //Code to set the book rating based on the users ratings.
  }

  //Getters.
  getISBN() => _isbn;
  getTitle() => _title;
  getAuthor() => _author;
  getYear() => _year;
  getPublisher() => _publisher;
  getSynopsis() => _synopsis;
  getImageL() => _imageURL;

  getRating() => _rating;

}