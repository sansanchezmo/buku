import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/main_objects/publication.dart';
import 'package:buku/scaffolds/others_scaffolds/user_search_scf.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/config_cache.dart';
import 'package:buku/widgets/book_image_horizonal_slider.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as FS;
import 'package:flutter/material.dart';

class ForumScaffold extends StatefulWidget {
  @override
  _ForumScaffoldState createState() => _ForumScaffoldState();
}

class _ForumScaffoldState extends State<ForumScaffold> {
  bool boolPublication;
  TextEditingController _publicationController = TextEditingController();
  @override
  void initState() {
    boolPublication = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 165,
            decoration: BoxDecoration(
                gradient: CurrentTheme.primaryGradientColorInverted,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40))),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                children: [
                  Container(
                    width: 55,
                    height: 60,
                    child: Image(
                      image: AssetImage("assets/images/bukusymbol.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 60,
                    height: 20,
                    child: Image(
                      image: AssetImage("assets/images/bukuword.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(child: SizedBox(height: 10)),
                  IconButton(
                      icon: Icon(Icons.person_search,
                          color: Colors.white70, size: 25),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserSearchScaffold())
                        );
                      })
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          askPublication(),
          //Divider(height: 1, thickness: 1,),
          Expanded(

              child: SingleChildScrollView(child: Publications())
          ),
        ],
      )),
    );
  }

  Widget askPublication(){

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          ProfileAvatar(size: 40, profileImage: MainUser.imagePath,),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              setState(() {
               addComment();
              });
            },
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: CurrentTheme.backgroundContrast
              ),
              child: Center(
                child: Text(
                  'Say something...',
                  style: TextStyle(
                    color: CurrentTheme.textColor2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  void addComment(){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:  (_) => AlertDialog(
        title: Row(
          children: [
            Text(
              'Give us your opinion',
              style: TextStyle(
                fontSize: 14,
                color: CurrentTheme.textColor1
              ),
            ),
            Expanded(child: SizedBox(height: 5,)),
            GestureDetector(
              onTap: (){

                if(_publicationController.text == null || _publicationController.text == '' || _publicationController.text == ' '){

                  setState(() {
                    boolPublication = false;
                  });
                  return;
                }

                Publication newPublication = Publication(MainUser.user.toMiniUser(),
                    _publicationController.text, FS.Timestamp.now(),
                    ConfigCache.forumSelectedMiniBook);
                if(ConfigCache.forumSelectedMiniBook == null) Firestore().createPublicationWithoutBook(newPublication);
                else Firestore().createPublication(newPublication);

              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: CurrentTheme.primaryColor
                ),
                child: Text(
                  'publish',
                  style: TextStyle(
                    fontSize: 14,
                    color: CurrentTheme.backgroundContrast
                  ),
                ),
              ),
            )
          ],
        ),
        content: Container(
          height: 317,
          child: SingleChildScrollView(
            child: Column(

              children: [
                TextField(
                controller: _publicationController,
                maxLines: null,
                maxLength: 250,
                cursorColor: CurrentTheme.textColor1,
                style: TextStyle(color: CurrentTheme.textColor3),
                decoration: InputDecoration(
                  errorText: boolPublication? null : 'I can not accept empty comments.',
                    labelText: 'Write something',
                    labelStyle: TextStyle(
                      color: CurrentTheme.primaryColorVariant,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: CurrentTheme.primaryColorVariant)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: CurrentTheme.primaryColorVariant)),
                    helperStyle: TextStyle(color: CurrentTheme.textColor3)),
                ),
                BookImageHorizontalSlider()
              ]
            ),
          ),
        ),
      )
    );
  }

  /*Widget _favBooksScroll() {
    List<Widget> userFavBooks = List<Widget>();
    for (int i = 0; i < MainUser.favBooks.length; i++) {
      MiniBook book = MainUser.favBooks[i];
      userFavBooks.add(Container(
        color: book.isbn10 == selectedBook? CurrentTheme.primaryColor
        : CurrentTheme.background,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: (){
            setState(() {
              selectedBook = book.isbn10;
            });
          },
          child: book.miniBookImage(),
        ),
      ));
    }
    return Container(
      height: 235,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: userFavBooks,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }*/

  Widget Publications(){

    return StreamBuilder(
        stream: Firestore().getForumStream(),
        builder: (context, snapshot) {

          return !snapshot.hasData
              ? Text('Please Wait')
              : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {

              FS.DocumentSnapshot publicationSnap = snapshot.data.documents[index];
              MiniBook book;
              try {
                book = MiniBook(
                    publicationSnap['book_isbn'], publicationSnap['book_title'],
                    null, publicationSnap['book_image_url']);
              }catch (e){

              }
              MiniUser user = MiniUser(publicationSnap['user_uid'], publicationSnap['user_name'], publicationSnap['user_nickname'], publicationSnap['user_image_path']);
              Publication publication = Publication(user, publicationSnap['body'], publicationSnap['date'], book);
              return publication.toWidget(context);

            },
          );

        },
    );

  }

  /*List<Widget> _publicationList() {
    List<Widget> publications = new List<Widget>();
    MiniUser user1 = new MiniUser("sdicnwlas", "Daniel Quiroga P", "DquirogaP",
        "assets/user_images/user_6.png");
    MiniUser user2 = new MiniUser("sdicnwlas", "Otro nombre bien prron",
        "user209302891", "assets/user_images/user_4.png");
    Timestamp time = Timestamp.now();
    MiniBook mini1 = new MiniBook(
        '0312289510',
        'The Christmas Shoes',
        ['Donna VanLiere'],
        'http://images.amazon.com/images/P/0312289510.01.LZZZZZZZ.jpg');
    MiniBook mini2 = new MiniBook(
        '0786014555',
        'Dark Masques',
        ['J. N. Williamson'],
        'http://images.amazon.com/images/P/0786014555.01.LZZZZZZZ.jpg');
    Publication pub1 =
        new Publication(user1, "Hey! I really like this book.", time, mini2);
    Publication pub2 = new Publication(
        user2,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mattis, turpis ut cursus ullamcorper, libero nunc interdum magna, vel hendrerit nisl leo ut erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed lorem pellentesque purus laoreet ornare vel eget enim.",
        time,
        mini1);
    Publication pub3 = new Publication(
        user1,
        "Nulla et libero dapibus, viverra sem sed, ultrices nunc. In hac habitasse platea dictumst. In id interdum mauris. Donec luctus eget magna tempus dictum.",
        time,
        null);
    Publication pub4 = new Publication(
        user2,
        "Vestibulum lacus nunc, faucibus vel eleifend at, sagittis vitae erat.",
        time,
        mini2);
    publications.add(pub3.toWidget(context));
    publications.add(Divider());
    publications.add(pub1.toWidget(context));
    publications.add(Divider());
    publications.add(pub4.toWidget(context));
    publications.add(Divider());
    publications.add(pub2.toWidget(context));
    publications.add(Divider());
    publications.add(pub1.toWidget(context));
    publications.add(Divider());
    publications.add(pub3.toWidget(context));
    publications.add(Divider());
    publications.add(pub4.toWidget(context));
    publications.add(Divider());
    publications.add(pub2.toWidget(context));
    return publications;
  }*/
}
