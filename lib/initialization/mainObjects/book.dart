class Book{
  //Instance attributes
  final String _isbn, _title, _author, _year, _publisher, _synopsis;
  final String _imageURLS, _imageURLM, _imageURLL;
  double _rating;

  //Constructor
  Book(this._isbn, this._title, this._author, this._year, this._publisher, this._synopsis, this._imageURLS, this._imageURLM, this._imageURLL) {
    scanBookRating();
  }

  scanBookRating(){
      _rating = 3.1; //Code to set the book rating based on the users ratings.
  }

  //Getters.
  getISBN() => _isbn;
  getTitle() => _title;
  getAuthor() => _author;
  getYear() => _year;
  getPublisher() => _publisher;
  getSynopsis() => _synopsis;
  getImageS() => _imageURLS;
  getImageM() => _imageURLM;
  getImageL() => _imageURLL;

  getRating() => _rating;

}