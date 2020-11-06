import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';

class TestPagesScaffold extends StatefulWidget {
  @override
  _TestPagesScaffoldState createState() => _TestPagesScaffoldState();
}

class _TestPagesScaffoldState extends State<TestPagesScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CurrentTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CurrentTheme.textColor1,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: CurrentTheme.background,
        title: Text(
          'Choose Test Page',
          style: TextStyle(
            fontFamily: 'ProductSans',
            color: CurrentTheme.textColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/testprimitive');
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: CurrentTheme.searchBarText,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Primitive Data",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/testbook');
                  }, // Stack Method.
                  child: Container(
                    width: 150,
                    height: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: CurrentTheme.primaryColorVariant,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Book Data",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(height: 10)
            ],
          )
        ],
      ),
    );
  }
}
