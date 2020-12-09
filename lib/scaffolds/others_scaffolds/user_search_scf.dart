import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/author.dart';
import 'package:buku/main_objects/book.dart';
import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/mini_user.dart';
import 'package:buku/main_objects/tag.dart';
import 'package:buku/main_objects/user.dart';
import 'package:buku/scaffolds/book_info_scaffolds/book_info_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/author_info_scf.dart';
import 'package:buku/scaffolds/others_scaffolds/other_user_scf.dart';
import 'package:buku/search_engine/search.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/user_to_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/* TODO:
- Search method.
- List view.
- Result pages Array.
- Filters.
 */

class UserSearchScaffold extends StatefulWidget {
  @override
  _UserSearchScaffoldState createState() => _UserSearchScaffoldState();
}

class _UserSearchScaffoldState extends State<UserSearchScaffold> with TickerProviderStateMixin{
  TextEditingController _searchTextController;
  TabController _searchTabController;
  List<Widget> _allResults;
  List<Widget> _bookResults;
  List<Widget> _authorResults;
  List<Widget> _tagResults;

  String _cache, _toSearch;

  @override
  void initState(){
    _searchTabController = new TabController(length: 4, vsync: this,initialIndex: 0);
    _searchTextController = TextEditingController(text: "");
    _cache = _toSearch = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, width: double.infinity,
        child: Column(
          children: [
            _searchHeader(this),
            SizedBox(height: 15),
            Expanded(
                child:  _resultTab()
            )
            /*Expanded(
              child: TabBarView(
                controller: _searchTabController,
                children: [
                  _resultTab(0),
                  _resultTab(1),
                  _resultTab(2),
                  _resultTab(3),
                ],
              ),
            )*/
          ],
        ),
      ),
    );
  }

  Widget _searchHeader(_UserSearchScaffoldState parent){
    return Container(
      height: 125,
      width: double.infinity,
      padding: EdgeInsets.only(top: 40,bottom: 15,left: 15, right: 15),
      decoration: BoxDecoration(
          gradient: CurrentTheme.primaryGradientColor,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchBar(parent),
          //SizedBox(height: 10),
          //_navTabs()
        ],
      ),
    );
  }

  Widget _searchBar(_UserSearchScaffoldState parent){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
            minWidth: 50,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white70)),
        Container(
          height: 45,
          width: 260,
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: CurrentTheme.searchBar,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: TextField(
            onSubmitted: (string) async{
              print('---------------------------------------olEEEEEE-------------------------');
              if(string.trim().toLowerCase() != _cache){
                parent.setState(() {
                  _toSearch = string.trim().toLowerCase();
                });
              }
            },
            controller: _searchTextController,
            autofocus: false,
            decoration: InputDecoration(
                border: InputBorder.none,
                disabledBorder: null,
                enabledBorder: null,
                hintText: "Search here...",
                hintStyle: TextStyle(
                    color: CurrentTheme.searchBarText
                ),
                icon: Icon(Icons.search, color: CurrentTheme.searchBarIcon)
            ),
          ),
        ),
        /*SizedBox(width: 10),
        FlatButton(
            minWidth: 50,
            onPressed: () {},
            child: Icon(Icons.filter_list,color: CurrentTheme.searchBar))*/
      ],
    );
  }

  /*Widget _navTabs(){
    return TabBar(
      controller: _searchTabController,
      labelStyle: TextStyle(color:Colors.white70,fontSize: 15),
      unselectedLabelStyle: TextStyle(color:CurrentTheme.searchBar,fontSize: 14),
      indicatorColor: CurrentTheme.searchBar,
      labelPadding: EdgeInsets.symmetric(horizontal: 10),
      tabs: [
        Tab(text: "All"),
        Tab(text: "Books"),
        Tab(text: "Authors"),
        Tab(text: "Categories"),
      ],
    );
  }*/

  Widget _resultTab(){
    /*Function future;
    if(index == 0){
      future = _allSearchResults;
    }
    else if(index == 1){
      future = _bookSearchResults;
    }
    else if(index == 2){
      future = _authorSearchResults;
    }
    else {
      future = _tagSearchResults;
    }*/
    return SingleChildScrollView(
        child: FutureBuilder(
          future: _results(_toSearch),
          builder: (cont,snap) {
            if(snap.connectionState != ConnectionState.done){
              return Center(
                child: Text(
                    'We are processing your consult'
                ),
              );
            }
            if(snap.hasData){
              return Column(
                children: snap.data,
              );
            }
            return Center(
              child: Text(
                  'We are processing your consult'
              ),
            );
          },
        )
    );
  }

  Future<List<Widget>> _results(String toSearch) async{
    if(toSearch == '') return [];
    _cache = _toSearch;
    List<MiniUser> results = await Search.searchUser(toSearch, tolerance: 3);
    List<Widget> resultsWidgets = [];
    for(MiniUser miniUser in results){
      resultsWidgets.add(GestureDetector(
        onTap: () async{
          String uid = miniUser.uid;
          User user= await Firestore().getUser(uid);
          Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => OtherUserScaffold(user))
          );
        },
        child: Container(
          child: UserToWidget(user: miniUser),
        ),
      ));
    }
    return resultsWidgets;

  }

  Future<List<Widget>> _allSearchResults(String toSearch) async {
    if(toSearch == '') return [];
    if(_allResults == null || _allResults.length == 0 || _toSearch!=_cache) {
      List<dynamic> results = await Search.search(toSearch);
      List<Widget> resultsWidgets = List<Widget>();
      for (dynamic result in results) {
        resultsWidgets.add(_dynamicResultToWidget(result));
      }
      _allResults = resultsWidgets;
      return resultsWidgets;
    }
    return _allResults;
  }

  Future<List<Widget>> _bookSearchResults(String toSearch) async {
    if(toSearch == '') return [];
    if(_bookResults == null || _bookResults.length == 0|| _toSearch!=_cache) {
      List<MiniBook> results = await Search.searchBook(toSearch);
      List<Widget> resultsWidgets = List<Widget>();
      for (MiniBook result in results) {
        resultsWidgets.add(GestureDetector(
          onTap: () async{
            Book book = await Firestore().getBook(result.isbn10);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
            );
          },
          child: result.toResultWidget(),
        ));
      }
      _bookResults = resultsWidgets;
      return resultsWidgets;
    }
    return _bookResults;
  }

  Future<List<Widget>> _authorSearchResults(String toSearch) async{
    if(toSearch == '') return [];
    if(_authorResults == null || _authorResults.length == 0 || _toSearch!=_cache) {
      List<MiniAuthor> results = await Search.searchAuthor(toSearch);
      List<Widget> resultsWidgets = List<Widget>();
      for (MiniAuthor result in results) {
        resultsWidgets.add(GestureDetector(
          onTap: () async{
            print('entro');
            Author author = await Firestore().getAuthor(result.name);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthorInfoScaffold(author)),
            );
          },
          child: result.toResultWidget(),
        ));
      }
      _authorResults = resultsWidgets;
      return resultsWidgets;
    }
    return _authorResults;
  }

  Future<List<Widget>> _tagSearchResults(String toSearch) async{
    if(toSearch == '') return [];
    if(_tagResults == null || _tagResults.length == 0 || _toSearch!=_cache) {
      _cache = _toSearch;
      List<Tag> results = Search.searchTag(toSearch);
      List<Widget> resultsWidgets = List<Widget>();
      for (Tag result in results) {
        resultsWidgets.add(result.toWidget());
      }
      _tagResults = resultsWidgets;
      return resultsWidgets;
    }
    return _tagResults;
  }

  Widget _dynamicResultToWidget(dynamic result){
    if(result.runtimeType == Tag){
      return result.toWidget();
    }
    else if (result.runtimeType == MiniBook || result.runtimeType == MiniAuthor){
      if(result.runtimeType == MiniBook){
        return GestureDetector(
          onTap: () async{
            Book book = await Firestore().getBook(result.isbn10);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookInfoScaffold(book: book)),
            );
          },
          child: result.toResultWidget(),
        );
      }
      //return result.toResultWidget();
      return GestureDetector(
        onTap: () async{
          Author author = await Firestore().getAuthor(result.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AuthorInfoScaffold(author)),
          );
        },
        child: result.toResultWidget(),
      );
    }
    else {
      return Container(height: 20,width: 20,color: Colors.deepPurple);
    }
  }
}