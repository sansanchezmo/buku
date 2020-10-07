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
                  onTap: (){},// Stack Method.
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
                    onTap: (){},// Stack Method.
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
    var books = new List<Book>(); // TODO: method that returns nData books to enqueue and dequeue from database.
    var bookQueue;
    if(array){
      bookQueue = new ArrayQueue<Book>();
    } else {
      bookQueue = new ListQueue<Book>();
    }
    for (Book book in books){ //Take time for enqueue
      bookQueue.push(book);
    }
    print("Time to enqueue "+_nData.toString()+" data: ");
    while(!bookQueue.empty()){ //Take time for dequeue
      bookQueue.pop();
    }
    print("Time to dequeue "+_nData.toString()+" data: ");
  }
}
