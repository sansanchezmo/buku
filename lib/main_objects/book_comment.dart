import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BookComment {

  // ignore: slash_for_doc_comments
  /**This class contains the info of the book comments.
  *+ Attributes:
  *   _userUID. The user's identification. This is used when we want to access another user profile.
  *   _userName. The user's name.
  *   _userNickName. The user's nickName. It contains the '@'
   *   _userProfilePic. The path where the user profile picture is. (Example: assets/user_images/user_3.png)
  *   _comment. The text of the comment.
  *   _date. The date when the comment was updated.
  *
  * Methods:
  *
  *+ Public methods:
  *   - (Widget) toWidget() -> returns a widget that display the formatted comment. Used in the BookInfoScaffold.
  *
  *+ Private methods:
  *   - (Widget) _userInfoWidget() -> returns the header of the toWidget comment.
  *   - (Widget) _commentText() -> returns the text of the comment (body of the toWidget comment).
  */

  ///Instance Attributes
  final String _userUID;
  final String _userName;
  final String _userNickName;
  final String _userProfilePic;
  final String _comment;
  final Timestamp _date;

  ///Constructor
  BookComment(this._userUID, this._userName, this._userNickName, this._userProfilePic, this._comment, this._date);

  ///Getters
  String get userUID => _userUID;
  String get userName => _userName;
  String get userNickName => _userNickName;
  String get userProfilePic => _userProfilePic;
  String get comment => _comment;
  Timestamp get date => _date;

  ///---------------------------PUBLIC METHODS------------------------------///

  Widget toWidget(){
    /**
     * returns a widget that display the formatted comment. Used in the BookInfoScaffold.
     **/
   return Container(
     //padding: EdgeInsets.only(top:10,bottom: 10),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         _userInfoWidget(),
         _commentText(),
         Container(
           width: double.infinity,
           padding: EdgeInsets.only(right: 20),
           alignment: Alignment.centerRight,
           child: Text(this._date.toDate().toString()),
         ),
         Divider(height: 25, thickness: 1, color: CurrentTheme.separatorColor),
       ],
     ),
   );
  }

  ///-------------------------PRIVATE METHODS-----------------------------///

  Widget _userInfoWidget(){
    /**
     * returns the header of the toWidget comment.
     **/
   return Container(padding: EdgeInsets.only(left:20,right: 20),
     alignment: Alignment.centerLeft,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.start,
       children: <Widget>[
         ProfileAvatar(size: 40,profileImage: this._userProfilePic,),
         SizedBox(width: 10),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               width: 270,
               padding: EdgeInsets.only(right: 20),
               child: Text(this._userName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(
                  fontSize: 17,
                  color: CurrentTheme.textColor1
                )),
             ),
             Text(this._userNickName,
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
   );
  }

  Widget _commentText(){
    /**
     * returns the text of the comment (body of the toWidget comment).
    * */
   return Container(
     padding: EdgeInsets.only(
         top: 10.0, right: 20.0,left: 20.0, bottom: 10.0),
     alignment: Alignment.centerLeft,
     child: Container(
       padding: EdgeInsets.only(
           top: 10.0, right: 20.0,left: 20.0, bottom: 10.0),
       decoration: BoxDecoration(
          color: CurrentTheme.backgroundContrast,
          borderRadius: BorderRadius.all(Radius.circular(10))),
       child: Text(this._comment,
         textAlign: TextAlign.justify,
         style: TextStyle(
           color: CurrentTheme.textColor3
          ),),
     )
   );
  }

}