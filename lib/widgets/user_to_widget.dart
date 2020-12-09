import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/main_objects/user.dart';
import 'package:buku/scaffolds/others_scaffolds/other_user_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class UserToWidget extends StatefulWidget{
  MiniUser user;

  UserToWidget({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserToWidgetState(user);

}

class _UserToWidgetState extends State<UserToWidget>{
  MiniUser user;
  bool isFollowed;

  _UserToWidgetState(this.user){
    //isFollowed = false;
    isFollowed = MainUser.haveFollower(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RaisedButton(
          onPressed: () async {
            User user = await Firestore().getUser(this.user.uid);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtherUserScaffold(user)),
            );
          },
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            children: [
              ProfileAvatar(size:50,profileImage: user.imagePath),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    child: Text(user.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 14,
                            color: CurrentTheme.textColor3
                        )),
                  ),
                  Text("@"+user.nickname,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 13,
                          color: CurrentTheme.textColor2
                      )),
                ],
              ),
              Expanded(child: SizedBox(),),
              this.user.uid == MainUser.uid? Container(width: 1,):
              isFollowed? Container(
                height: 25,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: CurrentTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(6))
                ),
                child: FlatButton(
                  onPressed: () async {
                    await MainUser.unfollow(user);
                    setState(()  {
                      isFollowed = false;
                    });

                  },
                  child: Text(
                    "Unfollow",

                    style: TextStyle(color: Colors.white70,fontSize: 12),
                  ),
                ),
              ) : Container(
                height: 25,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: CurrentTheme.background,
                    border: Border.all(color: CurrentTheme.primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(6))
                ),
                child: FlatButton(
                  onPressed: () async {
                    await MainUser.follow(user);
                    setState(()  {
                      isFollowed = true;
                    });
                  },
                  child: Text(
                    "Follow",
                    style: TextStyle(color: CurrentTheme.textColor2, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
          padding: EdgeInsets.all(15),
        ),
      ),
    );
  }

}