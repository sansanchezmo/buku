import 'package:buku/main_objects/user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class MiniUser{

  String _uid, _name, _nickname, _imagePath;

  MiniUser(this._uid, this._name, this._nickname, this._imagePath);

  String get uid => _uid;
  String get name => _name;
  String get nickname => _nickname;
  String get imagePath => _imagePath;

  Widget toWidget(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RaisedButton(
          onPressed: () async {
            /*User user = await Firestore().getAuthor(this._name);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtherUserScaffold(User: user)),
            );*/
          },
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            children: [
              ProfileAvatar(size:50,profileImage: this._imagePath),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    child: Text(this._name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 13,
                            color: CurrentTheme.textColor3
                        )),
                  ),
                  Text("@"+this._nickname,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 13,
                          color: CurrentTheme.textColor2
                      )),
                ],
              )
            ],
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}