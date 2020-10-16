import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimitiveTest extends StatefulWidget {
  @override
  _PrimitiveTestState createState() => _PrimitiveTestState();
}

class _PrimitiveTestState extends State<PrimitiveTest> {
  int nData = 10;
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
                    onTap: () async {},
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
                    onTap: () async {},
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
                    onTap: () async {},
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
                    onTap: () async {},
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
          ],
        ),
      ),
    );
  }
}
