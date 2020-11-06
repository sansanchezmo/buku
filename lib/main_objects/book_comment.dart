import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookComment {
  final String _userUID;
  final String _userName;
  final String _userNickName;
  final String _userProfilePic;
  final String _comment;
  final String _date;

 BookComment(this._userUID, this._userName, this._userNickName, this._userProfilePic, this._comment, this._date);

  Widget toWidget(){
   return Container(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         _userInfoWidget(),
         _commentText(),
         Container(
           width: double.infinity,
           padding: EdgeInsets.all(20),
           alignment: Alignment.centerRight,
           child: Text(this._date),
         )
       ],
     ),
   );
  }

  Widget _userInfoWidget(){
   return Container(
     alignment: Alignment.centerLeft,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[
         ProfileAvatar(size: 20,profileImage: this._userProfilePic,),
         Column(
           children: [
             Text(this._userName),
             Text(this._userNickName)
           ],
         )
       ],
     ),
   );
  }

  Widget _commentText(){
   return Container(
     padding: EdgeInsets.all(20.0),
     alignment: Alignment.centerLeft,
     child: Text(this._comment,
       textAlign: TextAlign.justify,
       style: TextStyle(

        ),)
   );
  }
}