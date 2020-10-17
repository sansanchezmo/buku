import 'package:buku/structs/queue.dart';
import 'package:buku/structs/stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimitiveTest extends StatefulWidget {
  @override
  _PrimitiveTestState createState() => _PrimitiveTestState();
}

class _PrimitiveTestState extends State<PrimitiveTest> {
  int nData = 10;
  bool doCharts = false;
  Stopwatch time = new Stopwatch();

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
      PrimitiveQueue.push(i);
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
      PrimitiveQueue.pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
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
              'Primitive Data',
              style: TextStyle(
                  color: Colors.grey,
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
                    setState(() {
                      doCharts = true;
                    });
                    print(nData);
                  },
                  decoration: new InputDecoration(labelText: "Data to process"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            ),
            SizedBox(
              height: 30.0,
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
                      child: Text(
                        "ArrayStack",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
                        "ListStack",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20.0),
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
                        "ArrayQueue",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
                        "ListQueue",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {},
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: doCharts ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "View chart",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
