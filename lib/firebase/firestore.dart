import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore{

  static final String nickName = 'nickName';
  static final String theme = 'theme';
  static final String name = 'name';
  static final String description = 'description';
  static final String userImgUrl = 'userImageUrl';
  static final String tags = 'tags';

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
    await store.collection('users').doc(uid).update({
      'theme' : theme,
      'name' : name,
      'description' : desc,
      'userImageUrl' : userImg,
      'tags': tags
    }).catchError((error) => throw Exception('there´s a problem with the user: Data not stored'));

  }

  void setOldUser(String uid) async{

    await store.collection('users').doc(uid).update({
      'newUser' : false
    }).catchError((error) => throw Exception('can´t set user to old'));

  }

  Future<dynamic> getData(String uid, String data) async {
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

  Future<bool> checkName(String name) async{
    List<String> names = [];
    await store.collection('users').get().then((value) {
      value.docs.forEach((element) {names.add(element.data()[nickName]);});
    });

    for(int i = 0; i<names.length;i++){
      if(names[i] == name) return false;
    }
    return true;
  }
}