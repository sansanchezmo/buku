import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileAvatar extends StatefulWidget{
  double size;
  String profileImage;
  ProfileAvatar({Key key, this.size: 100, this.profileImage}) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();

}

class _ProfileAvatarState extends State<ProfileAvatar>{
  _ProfileAvatarState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: CurrentTheme.backgroundContrast, width: 2),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage( widget.profileImage == null?
                  "assets/user_images/user_0.png": widget.profileImage))),
    );
  }

}