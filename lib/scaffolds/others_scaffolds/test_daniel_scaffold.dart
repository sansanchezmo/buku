import 'package:buku/main_objects/book_comment.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/scaffolds/others_scaffolds/users_list_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/user_to_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDanielScaffold extends StatefulWidget{

  @override
  _TestDanielScaffoldState createState() => _TestDanielScaffoldState();

}

class _TestDanielScaffoldState extends State<TestDanielScaffold>{
  @override
  Widget build(BuildContext context) {
    List<MiniUser> test = [
      new MiniUser("jsdlafkj0", "Nombre de usuario 1", "NickName921", "assets/user_images/user_5.png"),
      new MiniUser("jsdlafkj0", "Nombre de  2", "NickName9223", "assets/user_images/user_4.png"),
      new MiniUser("jsdlafkj0", "Nombre de usuario 3", "NickName922", "assets/user_images/user_1.png"),
      new MiniUser("jsdlafkj0", "Nombre de usuario 4", "NickName923", "assets/user_images/user_3.png"),
      new MiniUser("jsdlafkj0", "Nombre de usuario 5", "NickName924", "assets/user_images/user_4.png")
    ];
    
    return UsersListScaffold(test, "Followers");
 }

}