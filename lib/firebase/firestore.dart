import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Firestore{

  FirebaseFirestore store;

  Firestore(){
    store = FirebaseFirestore.instance;
  }

  void createUser(String uid, String nickName) async{

    await store.collection('users').doc(uid).set({
      'newUser' : true,
      'nickName' : nickName
    }).then((value) => print("user added"))
        .catchError((error) => print("there´s a problem with the user: Not created"));

  }

  Future<bool> isNew(String uid) async{
    bool isNew;
    await store.collection('users').doc(uid).get().then((doc) {
      isNew = doc.data()['newUser'];
    });
    print(isNew.toString());

    return isNew;
  }
}