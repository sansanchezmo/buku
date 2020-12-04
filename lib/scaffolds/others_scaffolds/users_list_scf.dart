
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/user_to_widget.dart';
import 'package:flutter/material.dart';

class UsersListScaffold extends StatefulWidget{
  List<MiniUser> users;
  String title;

  UsersListScaffold(this.users, this.title, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UsersListScaffoldState();

}

class _UsersListScaffoldState extends State<UsersListScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CurrentTheme.background,
      appBar: AppBar(
        backgroundColor: CurrentTheme.primaryColor,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            },
          icon: Icon(Icons.arrow_back),
          color: Colors.white70
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _usersWidgetList(),
      ),
    );
  }

  List<Widget> _usersWidgetList(){
    List<Widget> widgetList = new List<Widget>();
    for(MiniUser user in widget.users){
      widgetList.add(new UserToWidget(user: user));
    }
    return widgetList;
  }

}
