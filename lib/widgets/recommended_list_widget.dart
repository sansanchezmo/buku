import 'package:buku/main_objects/book.dart';
import 'package:buku/widgets/recommended_list.dart';
import 'package:flutter/cupertino.dart';

class RecommendedListWidget extends StatefulWidget{
  _RecommendedListWidgetState createState() => _RecommendedListWidgetState();
}

class _RecommendedListWidgetState extends State<RecommendedListWidget>{
  @override
  Widget build(BuildContext context) {
    List<Book> list= [];
    for (int i = 0; i < 5; i++) {
      /*Book book = new Book(
          "0002005018",
          "Classical Mythology",
          "Mark P. O. Morford",
          "2002",
          "Oxford University Press",
          "Building on the bestselling tradition of previous editions, Classical Mythology, Tenth Edition, is the most comprehensive survey of classical mythology available--and the first full-color textbook of its kind. Featuring the authors' clear and extensive translations of original sources, it brings to life the myths and legends of Greece and Rome in a lucid and engaging style. The text contains a wide variety of faithfully translated passages from Greek and Latin sources, including Homer, Hesiod, all the Homeric Hymns, Pindar, Aeschylus, Sophocles, Euripides, Herodotus, Plato, Lucian, Lucretius, Vergil, Ovid, and Seneca. ",
          "http://images.amazon.com/images/P/0195153448.01.THUMBZZZ.jpg",
          "link2",
          "http://images.amazon.com/images/P/0195153448.01.LZZZZZZZ.jpg");*/
      Book book;
      list.add(book);
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RecommendedList(list: list),
              SizedBox(width: 30,),
              RecommendedList(list: list),
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RecommendedList(list: list),
              SizedBox(width: 30,),
              RecommendedList(list: list),
            ],
          )
        ],
      ),
    );
  }

}