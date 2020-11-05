import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*TODO: get user's avatar. */

class ProfileAvatar extends StatefulWidget{
  double size;
  ProfileAvatar({Key key, this.size: 100}) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState(size);

}

class _ProfileAvatarState extends State<ProfileAvatar>{
  double size;
  _ProfileAvatarState(this.size);

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
              image: NetworkImage(
                  "https://images.megapixl.com/4707/47075236.jpg"))),
    );
  }

}