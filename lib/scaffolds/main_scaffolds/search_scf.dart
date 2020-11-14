import 'package:buku/main_objects/mini_author.dart';
import 'package:buku/main_objects/mini_book.dart';
import 'package:buku/main_objects/tag.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/* TODO:
- Search method.
- List view.
- Result pages Array.
- Filters.
 */

class SearchScaffold extends StatefulWidget {
  @override
  _SearchScaffoldState createState() => _SearchScaffoldState();
}

class _SearchScaffoldState extends State<SearchScaffold> with TickerProviderStateMixin{
  TextEditingController _searchTextController;
  TabController _searchTabController;
  List<Widget> _allResults;
  List<Widget> _bookResults;
  List<Widget> _authorResults;
  List<Widget> _tagResults;

  @override
  void initState(){
    _searchTabController = new TabController(length: 4, vsync: this,initialIndex: 0);
    _searchTextController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity, width: double.infinity,
        child: Column(
          children: [
            _searchHeader(),
            SizedBox(height: 15),
            Expanded(
              child: TabBarView(
                controller: _searchTabController,
                children: [
                  _resultTab(0),
                  _resultTab(1),
                  _resultTab(2),
                  _resultTab(3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchHeader(){
    return Container(
      height: 165,
      width: double.infinity,
      padding: EdgeInsets.only(top: 40,bottom: 15,left: 15, right: 15),
      decoration: BoxDecoration(
        gradient: CurrentTheme.primaryGradientColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)
        )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _searchBar(),
          SizedBox(height: 10),
          _navTabs()
        ],
      ),
    );
  }

  Widget _searchBar(){
    return Row(
      children: [
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
            onSubmitted: (string) {}, // TODO: change method.
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
        SizedBox(width: 10),
        FlatButton(
          minWidth: 50,
            onPressed: () {},
            child: Icon(Icons.filter_list,color: CurrentTheme.searchBar))
      ],
    );
  }

  Widget _navTabs(){
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
  }

  Widget _resultTab(int index){
    Function future;
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
    }
    return SingleChildScrollView(
      /*child: FutureBuilder(
        future: future(),
        builder: (snapshot) {

        },
      )*/
    );
  }

  Future<List<Widget>> _allSearchResults() async {
    if(_allResults == null || _allResults.length == 0) {
      List<dynamic> results = await List<dynamic>();//TODO: Method that returns a list of any type
      List<Widget> resultsWidgets = List<Widget>();
      for (dynamic result in results) {
        resultsWidgets.add(_dynamicResultToWidget(result));
      }
      _allResults = resultsWidgets;
      return resultsWidgets;
    }
    return _allResults;
  }

  Future<List<Widget>> _bookSearchResults() async {
    if(_bookResults == null || _bookResults.length == 0) {
      List<MiniBook> results = await List<MiniBook>(); //TODO: List of ONLY MiniTags.
      List<Widget> resultsWidgets = List<Widget>();
      for (MiniBook result in results) {
        resultsWidgets.add(result.toResultWidget());
      }
      _bookResults = resultsWidgets;
      return resultsWidgets;
    }
    return _bookResults;
  }

  Future<List<Widget>> _authorSearchResults() async{
    if(_authorResults == null || _authorResults.length == 0) {
      List<MiniAuthor> results = await List<MiniAuthor>(); //TODO: List of ONLY MiniAuthors.
      List<Widget> resultsWidgets = List<Widget>();
      for (MiniAuthor result in results) {
        resultsWidgets.add(result.toResultWidget());
      }
      _authorResults = resultsWidgets;
      return resultsWidgets;
    }
    return _authorResults;
  }

  Future<List<Widget>> _tagSearchResults() async{
    if(_tagResults == null || _tagResults.length == 0) {
      List<Tag> results = await List<Tag>(); //TODO: List of ONLY tags.
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
      return result.toResultWidget();
    }
    else {
      return Container(height: 20,width: 20,color: Colors.deepPurple);
    }
  }
}
