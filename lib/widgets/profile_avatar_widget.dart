import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*TODO: get user's avatar. */

class ProfileAvatar extends StatefulWidget{
  double size;
  String profileImage;
  ProfileAvatar({Key key, this.size: 100, this.profileImage}) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState(size,profileImage);

}

class _ProfileAvatarState extends State<ProfileAvatar>{
  double size;
  String profileImage;
  _ProfileAvatarState(this.size,this.profileImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: CurrentTheme.backgroundContrast, width: 0.5),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage( profileImage == null?
                  "https://images.megapixl.com/4707/47075236.jpg": profileImage))),
    );
  }

}