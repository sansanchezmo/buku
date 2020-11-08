import 'package:buku/main_objects/book_comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDanielScaffold extends StatefulWidget{

  @override
  _TestDanielScaffoldState createState() => _TestDanielScaffoldState();

}

class _TestDanielScaffoldState extends State<TestDanielScaffold>{
  @override
  Widget build(BuildContext context) {
    BookComment comment1 = new BookComment("_userUID", "Patata roja", "@Kepedales__", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRvpVkmlEuN8y_vJ1eBZ8k7E62OGAUdEL3l9Q&usqp=CAU", "This book is amazing!", "20 October 2020");
    BookComment comment2 = new BookComment("_userUID", "Aguacate con el nombre más largo de la existencia del universo universal", "@__jklsfjlask__", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRvpVkmlEuN8y_vJ1eBZ8k7E62OGAUdEL3l9Q&usqp=CAU", "TLorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ex nisl, auctor id tortor nec, accumsan aliquet elit. Proin ultricies ligula magna, vel facilisis lorem ullamcorper sagittis. In hac habitasse platea dictumst. Phasellus purus neque, molestie ut dapibus ac, commodo nec nisi. Curabitur nunc nisi, bibendum vitae lectus ut, cursus faucibus mi. Maecenas interdum interdum lacus, ut vehicula velit porttitor at. Aliquam erat volutpat. Vivamus non congue ipsum. Duis molestie, enim at varius fringilla, nulla ipsum tincidunt nisl, vitae placerat.", "20 October 2020");
    BookComment comment3 = new BookComment("_userUID", "Daniel Quiroga", "@lrogav1234", "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRvpVkmlEuN8y_vJ1eBZ8k7E62OGAUdEL3l9Q&usqp=CAU", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non malesuada lacus. Nullam interdum id ipsum sagittis rutrum. Aenean consequat suscipit felis id suscipit. Aliquam eu ornare mi, nec pretium risus. Etiam porttitor fringilla dui, sed consectetur nunc sagittis nec. Sed ornare pharetra sapien, eget elementum diam venenatis id. Nunc purus mauris, venenatis sit amet turpis non, vulputate condimentum odio. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae", "18 October 2020");

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            comment1.toWidget(),
            comment2.toWidget(),
            comment3.toWidget(),

          ],
        ),
      ),
    );
 }

}