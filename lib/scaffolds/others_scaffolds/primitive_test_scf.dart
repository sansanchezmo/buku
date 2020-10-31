import 'package:buku/main_objects/structs/linked_list.dart';
import 'package:buku/main_objects/structs/queue.dart';
import 'package:buku/main_objects/structs/stack.dart';
import 'package:buku/main_objects/structs/vector.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimitiveTestScaffold extends StatefulWidget {
  @override
  _PrimitiveTestScaffoldState createState() => _PrimitiveTestScaffoldState();
}

class _PrimitiveTestScaffoldState extends State<PrimitiveTestScaffold> {
  int nData = 10;
  Stopwatch time = new Stopwatch();

  // TEST METHODS: Four methods for each implemented structure.
  void testStacks(bool decide) {
    String message;
    var PrimitiveStack;
    switch (decide) {
      case true:
        {
          PrimitiveStack = new ArrayStack();
          print('------------Using ArrayStack------------');
        }
        break;
      case false:
        {
          PrimitiveStack = new ListStack();
          print('------------Using ListStack------------');
        }
        break;
    }
    //Pushing $nData elements
    time.start();
    for (int i = 0; i < nData; i++) {
      PrimitiveStack.push(i);
    }
    time.stop();
    message = 'Time to push ' +
        nData.toString() +
        ' integers: ' +
        time.elapsedMicroseconds.toString() +
        ' microseconds';
    print(message);
    time.reset();
    //Popping $nData elements
    time.start();
    for (int j = 0; j < nData; j++) {
      PrimitiveStack.pop();
    }
    time.stop();
    message = 'Time to pop ' +
        nData.toString() +
        ' integers: ' +
        time.elapsedMicroseconds.toString() +
        ' microseconds';
    print(message);
    time.reset();
  }

  void testQueues(bool decide) {
    String message;
    var PrimitiveQueue;
    switch (decide) {
      case true:
        {
          PrimitiveQueue = new ArrayQueue();
          print('------------Using ArrayQueue------------');
        }
        break;
      case false:
        {
          PrimitiveQueue = new ListQueue();
          print('------------Using ListQueue------------');
        }
        break;
    }
    //Pushing $nData elements
    time.start();
    for (int i = 0; i < nData; i++) {
      PrimitiveQueue.enqueue(i);
    }
    time.stop();
    message = 'Time to enqueue ' +
        nData.toString() +
        ' integers: ' +
        time.elapsedMicroseconds.toString() +
        ' microseconds';
    print(message);
    time.reset();
    //Popping $nData elements
    time.start();
    for (int j = 0; j < nData; j++) {
      PrimitiveQueue.dequeue();
    }
    time.stop();
    message = 'Time to dequeue ' +
        nData.toString() +
        ' integers: ' +
        time.elapsedMicroseconds.toString() +
        ' microseconds';
    print(message);
    time.reset();
  }

  void intVectorTest() {
    Vector<int> intVector = new Vector<int>();
    print('---------------Using Array---------------');
    time.reset();
    time.start();
    for (int i = 0; i < nData; i++) {
      intVector.pushFront(i);
    }
    print("Time to pushFront " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
    time.start();
    while (!intVector.empty()) {
      intVector.popFront();
    }
    print("Time to popFront " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
    time.start();
    for (int j = 0; j < nData; j++) {
      intVector.pushBack(j);
    }
    print("Time to pushBack " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
    time.start();
    while (!intVector.empty()) {
      intVector.popBack();
    }
    print("Time to popBack " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
  }

  void intLinkedListTest() {
    LinkedList<int> intLinkedList = new LinkedList<int>();
    print('---------------Using LinkedList---------------');
    time.reset();
    time.start();
    for (int i = 0; i < nData; i++) {
      intLinkedList.pushFront(i);
    }
    print("Time to pushFront " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
    time.start();
    while (!intLinkedList.empty()) {
      intLinkedList.popFront();
    }
    print("Time to popFront " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
    time.start();
    for (int j = 0; j < nData; j++) {
      intLinkedList.pushBack(j);
    }
    print("Time to pushBack " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
    time.start();
    while (!intLinkedList.empty()) {
      intLinkedList.popBack();
    }
    print("Time to popBack " +
        nData.toString() +
        " integers: " +
        time.elapsedMicroseconds.toString() +
        " microseconds");
    time.stop();
    time.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Image(
              image: AssetImage(
                'assets/images/settings.png',
              ),
              width: 150.0,
              height: 150.0,
            ),
            Text(
              'BUKUTest',
              style: TextStyle(
                color: CurrentTheme.textColor1,
                fontFamily: 'ProductSans',
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Primitive Data',
              style: TextStyle(
                  color: CurrentTheme.textColor2,
                  fontFamily: 'ProductSans',
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 30),
            Container(
              width: 150,
              child: TextField(
                  onSubmitted: (String number) async {
                    nData = int.parse(number);
                    print(nData);
                  },
                  decoration: new InputDecoration(labelText: "Data to process"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      testStacks(true);
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "ArrayStack Method",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      testStacks(false);
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ListStack Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      testQueues(true);
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent[700],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ArrayQueue Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      testQueues(false);
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent[700],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "ListQueue Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      intVectorTest();
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "Array Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      intLinkedListTest();
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "List Method",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10.0)
          ],
        ),
      ),
    );
  }
}
