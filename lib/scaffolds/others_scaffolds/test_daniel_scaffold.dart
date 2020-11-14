import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDanielScaffold extends StatefulWidget{

  @override
  _TestDanielScaffoldState createState() => _TestDanielScaffoldState();

}

class _TestDanielScaffoldState extends State<TestDanielScaffold>{
  @override
  Widget build(BuildContext context) {
    MiniAuthor auth = new MiniAuthor("Nombre Real", 'null');
    MiniAuthor auth2 = new MiniAuthor("Nombre Real Por Dos Montaña jadlsf sldfja sdña lejlwj slic", 'null');
    MiniBook book = new MiniBook("0001046438", "Título Real de un libro con nombre largo", ["Autor 1","autores"], 'http://images.amazon.com/images/P/0006275192.01.LZZZZZZZ.jpg');
    MiniBook book2 = new MiniBook("0001046438", "Helloooo este es otro nombre", ["autores"], 'http://images.amazon.com/images/P/0006275192.01.LZZZZZZZ.jpg');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120),
            auth.toResultWidget(),
            auth2.toResultWidget(),
            book.toResultWidget(),
            book2.toResultWidget()
          ],
        ),
      ),
    );
 }

}