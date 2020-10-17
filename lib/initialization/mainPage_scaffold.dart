import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';
import 'package:flutter/services.dart';
import 'mainObjects/book.dart';
import 'package:buku/database/database.dart';
import 'package:buku/structs/linked_list.dart';
import 'package:buku/structs/queue.dart';
import 'package:buku/structs/stack.dart';
import 'package:buku/structs/vector.dart';

class MainPage extends StatefulWidget {
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  Auth auth = new Auth();
  String email;
  int _nData = 10;
  Stopwatch _stopwatch = new Stopwatch();
  List<Book> _bookList = new List<Book>();

  @override
  Widget build(BuildContext context) {
    auth.getEmail();
    email = auth.email;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Image(
              image: AssetImage(
                'assets/images/test.png',
              ),
              width: 150.0,
              height: 150.0,
            ),
            Text(
              'BUKUTest',
              style: TextStyle(
                fontFamily: 'ProductSans',
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Book Data',
              style: TextStyle(
                color: Colors.deepOrange,
                fontFamily: 'ProductSans',
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 150,
              child: TextField(
                  onSubmitted: (String number) async {
                    _nData = int.parse(number);
                    _bookList.clear();
                    _bookList = await Database.getBookList(_nData);
                    print(
                        _bookList.length.toString() + " data was downloaded.");
                  },
                  //onChanged: (String number) {_nData = int.parse(number);},
                  decoration: new InputDecoration(labelText: "Data to process"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await _bookHistoryStack(true);
                    }, // Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ArrayStack Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () async {
                      await _bookHistoryStack(false);
                    }, // Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ListStack Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await _recomendationQueue(true);
                    }, // ListQueue Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ArrayQueue Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () async {
                      await _recomendationQueue(false);
                    }, // ListQueue Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ListQueue Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await _bookLinkedListTest();
                    }, // Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "List Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () async {await _bookVectorTest();}, // Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "Array Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                SizedBox(height: 10)
              ],
            )
          ],
        ),
      ),
    );
  }

  _recomendationQueue(bool array) async {
    var bookQueue;
    if (array) {
      bookQueue = new ArrayQueue<Book>();
    } else {
      bookQueue = new ListQueue<Book>();
    }
    _stopwatch.reset();
    _stopwatch.start();
    for (Book book in _bookList) {
      bookQueue.push(book);
    }
    print("Time to enqueue " +
        _nData.toString() +
        " books: " +
        _stopwatch.elapsedMicroseconds.toString() +
        " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    while (!bookQueue.empty()) {
      bookQueue.pop();
    }
    print("Time to dequeue " +
        _nData.toString() +
        " books: " +
        _stopwatch.elapsedMicroseconds.toString() +
        " us");
    _stopwatch.stop();
    _stopwatch.reset();
    /*int sumEnqueueTime = 0;
    int sumDequeueTime = 0;
    for (int i = 0; i < 20; i++) {
      _stopwatch.reset();
      _stopwatch.start();
      for (Book book in _bookList) {
        bookQueue.push(book);
      }
      sumEnqueueTime += _stopwatch.elapsedMicroseconds;
      _stopwatch.stop();
      _stopwatch.reset();
      _stopwatch.start();
      while(!bookQueue.empty()){
        bookQueue.pop();
      }
      sumDequeueTime += _stopwatch.elapsedMicroseconds;
      _stopwatch.stop();
    }
    print((sumEnqueueTime/20).toString() + " enqueue");
    print((sumDequeueTime/20).toString() + " dequeue");*/

  }

  _bookHistoryStack(bool array) async {
    var bookStack;
    if (array) {
      bookStack = new ArrayStack<Book>();
    } else {
      bookStack = new ListStack<Book>();
    }
    _stopwatch.reset();
    _stopwatch.start();
    for (Book book in _bookList) {
      bookStack.push(book);
    }
    print("Time to push " +
        _nData.toString() +
        " books: " +
        _stopwatch.elapsedMicroseconds.toString() +
        " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    while (!bookStack.empty()) {
      bookStack.pop();
    }
    print("Time to pop " +
        _nData.toString() +
        " books: " +
        _stopwatch.elapsedMicroseconds.toString() +
        " us");
    _stopwatch.stop();
    _stopwatch.reset();
    /*int sumPushTime = 0;
    int sumPopTime = 0;
    for (int i = 0; i < 20; i++) {
      _stopwatch.reset();
      _stopwatch.start();
      for (Book book in _bookList) {
        bookStack.push(book);
      }
      sumPushTime += _stopwatch.elapsedMicroseconds;
      _stopwatch.stop();
      _stopwatch.reset();
      _stopwatch.start();
      while(!bookStack.empty()){
        bookStack.pop();
      }
      sumPopTime += _stopwatch.elapsedMicroseconds;
      _stopwatch.stop();
    }
    print((sumPushTime/20).toString() + " push");
    print((sumPopTime/20).toString() + " pop");*/
  }

  _bookLinkedListTest() {
    LinkedList<Book> bookLinkedList = new LinkedList<Book>();
    _stopwatch.reset();
    _stopwatch.start();
    for (Book book in _bookList) {
        bookLinkedList.pushFront(book);
    }
    print("Time to pushFront " + _nData.toString()
          + " books: " + _stopwatch.elapsedMicroseconds.toString()
          + " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    while (!bookLinkedList.empty()) {
      bookLinkedList.popFront();
    }
    print("Time to popFront " +
        _nData.toString() +
        " books: " +
        _stopwatch.elapsedMicroseconds.toString() +
        " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    for (Book book in _bookList) {
      bookLinkedList.pushBack(book);
    }
    print("Time to pushBack " + _nData.toString() + " books: " +
        _stopwatch.elapsedMicroseconds.toString() + " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    while (!bookLinkedList.empty()) {
      bookLinkedList.popBack();
    }
    print("Time to popBack " + _nData.toString() + " books: " +
        _stopwatch.elapsedMicroseconds.toString() + " us");
    _stopwatch.stop();
    _stopwatch.reset();
  }

  _bookVectorTest() {
    Vector<Book> bookVector = new Vector<Book>();
    /*_stopwatch.reset();
    _stopwatch.start();
    for (Book book in _bookList) {
      bookVector.pushFront(book);
    }
    print("Time to pushFront " + _nData.toString()
        + " books: " + _stopwatch.elapsedMicroseconds.toString()
        + " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    while (!bookVector.empty()) {
      bookVector.popFront();
    }
    print("Time to popFront " +
        _nData.toString() +
        " books: " +
        _stopwatch.elapsedMicroseconds.toString() +
        " us");
    _stopwatch.stop();*/
    _stopwatch.reset();
    _stopwatch.start();
    for (Book book in _bookList) {
      bookVector.pushBack(book);
    }
    print("Time to pushBack " + _nData.toString() + " books: " +
        _stopwatch.elapsedMicroseconds.toString() + " us");
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    while (!bookVector.empty()) {
      bookVector.popBack();
    }
    print("Time to popBack " + _nData.toString() + " books: " +
        _stopwatch.elapsedMicroseconds.toString() + " us");
    _stopwatch.stop();
    _stopwatch.reset();
  }
}
