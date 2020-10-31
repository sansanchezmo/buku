import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore{

  static final String nickName = 'nickName';
  static final String theme = 'theme';

  FirebaseFirestore store;

  Firestore(){
    store = FirebaseFirestore.instance;
  }

  void createUser(String uid, String nickName) async{

    await store.collection('users').doc(uid).set({
      'newUser' : true,
      'nickName' : nickName
    }).then((value) => print("user added"))
        .catchError((error) => throw Exception('there´s a problem with the user: Not created'));

  }

  void storeMainData(String uid, String theme, String name, String desc, String userImg, List<String> tags) async{
    //TODO: change tags id for SQL id
    await store.collection('users').doc(uid).update({



      'theme' : theme,
      'name' : name,
      'description' : desc,
      'userImageUrl' : userImg,
    }).catchError((error) => throw Exception('there´s a problem with the user: Data not stored'));

    for( int i = 0; i<tags.length;i++){
      print(tags[i]);
      await store.collection('users').doc(uid).collection('tags').doc(uid+'_'+i.toString()).set({'name':tags[i]})
          .catchError((error) => throw Exception('there´s a problem with the user: Data not stored'));
    }

  }

  void setOldUser(String uid) async{

    await store.collection('users').doc(uid).update({
      'newUser' : false
    }).catchError((error) => throw Exception('can´t set user to old'));

  }

  Future<String> getData(String uid, String data) async {
    String nickName;
    await store.collection('users').doc(uid).get()
    .then((value) {
      nickName = value.data()[data];
    }).catchError((error) => throw Exception('No, we do not have $data data'));

    return nickName;

  }

  Future<bool> isNew(String uid) async{
    bool isNew;
    await store.collection('users').doc(uid).get().then((doc) {
      isNew = doc.data()['newUser'];
    });

    return isNew;
  }
}