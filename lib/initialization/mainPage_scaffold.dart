import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';
import 'package:flutter/services.dart';
import 'mainObjects/book.dart';
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
  int _nData = 0;
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
            SizedBox(height: 100),
            Image(
              image: AssetImage(
                'assets/images/bukusymbol.png',
              ),
              width: 150.0,
              height: 150.0,
            ),
            SizedBox(height: 30,),
            Text(
              'You logged in with:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              email,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 150,
              child: TextField(
                onChanged: (String number) {_nData = int.parse(number);},
                decoration: new InputDecoration(labelText: "Data to process"),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async { await _bookHistoryStack(true);},// Stack Method.
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text("ArrayStack Method",
                      style: TextStyle(color: Colors.white,fontSize: 16),),
                  )
                ),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () async { await _bookHistoryStack(false);},// Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text("ListStack Method",
                        style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async { await _recomendationQueue(true);}, // ListQueue Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text("ArrayQueue Method",
                        style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () async { await _recomendationQueue(false);}, // ListQueue Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text("ListQueue Method",
                        style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){},// Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text("List Method",
                        style: TextStyle(color: Colors.white,fontSize: 16),
                      ),
                    )
                ),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: (){},// Stack Method.
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text("Array Method",
                        style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _recomendationQueue(bool array){
    var time1,time2;
    // var books = Database.getBookList(_nData);
    var books = new List<Book>();
    var bookQueue;
    if(array){
      bookQueue = new ArrayQueue<Book>();
    } else {
      bookQueue = new ListQueue<Book>();
    }
    time1 = DateTime.now().microsecondsSinceEpoch;
    for (Book book in books){
      bookQueue.push(book);
    }
    time2 = DateTime.now().microsecondsSinceEpoch;
    print("Time to enqueue "+_nData.toString()+" books: "+(time2-time1).toString() + "us");
    time1 = DateTime.now().microsecondsSinceEpoch;
    while(!bookQueue.empty()){
      bookQueue.pop();
    }
    time2 = DateTime.now().microsecondsSinceEpoch;
    print("Time to dequeue "+_nData.toString()+" books: "+(time2-time1).toString() + "us");
  }

  _bookHistoryStack(bool array){
    var time1, time2;
    // var books = Database.getBookList(_nData);
    var books = new List<Book>();
    var bookStack;
    if(array){
      bookStack = new ArrayStack<Book>();
    } else {
      bookStack = new ListStack<Book>();
    }
    time1 = DateTime.now().microsecondsSinceEpoch;
    for (Book book in books){
      bookStack.push(book);
    }
    time2 = DateTime.now().microsecondsSinceEpoch;
    print("Time to push "+_nData.toString()+" books: "+(time2-time1).toString() + "us");
    time1 = DateTime.now().microsecondsSinceEpoch;
    while(!bookStack.empty()){
      bookStack.pop();
    }
    time2 = DateTime.now().microsecondsSinceEpoch;
    print("Time to pop "+_nData.toString()+" books: "+(time2-time1).toString() + "us");
  }
}
