import 'package:buku/main_objects/structs/tree.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';

class ListInfoScaffold extends StatefulWidget {
  final BookListComponent listComponent;
  ListInfoScaffold(this.listComponent);

  @override
  _ListInfoScaffoldState createState() => _ListInfoScaffoldState(listComponent);
}

class _ListInfoScaffoldState extends State<ListInfoScaffold> {
  BookListComponent _listComponent;
  _ListInfoScaffoldState(this._listComponent);

  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: 140,
              width: double.infinity,
              padding: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    //bottomRight: Radius.circular(40)
                  ),
                boxShadow: [
                  BoxShadow(
                      color: CurrentTheme.shadow1,
                      spreadRadius: 5,
                      blurRadius: 10)
                ],
                gradient: CurrentTheme.primaryGradientColorInverted,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _listComponent.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        String title;
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('New List'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text("Type the name of your new list:"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'List Name',
                                      ),
                                      controller: _controller,
                                      onSubmitted: (String value) {
                                        title = value;
                                      },
                                    )
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Create'),
                                  onPressed: () {
                                    setState(() {
                                      title == null
                                          ? title =
                                              _listComponent.name + '01'
                                          : print('New list: ' + title);
                                      BookListComponent listComponent =
                                          new BookListComponent(
                                              _listComponent, title);
                                      _listComponent.children
                                          .add(listComponent);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.playlist_add,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            height: 500,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(5),
                      children: _listComponent.children.map((list) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListInfoScaffold(list)),
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: LinearGradient(colors: [
                                      Colors.red,
                                      Colors.redAccent[100],
                                    ])),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      list.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  ],
                                )),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
