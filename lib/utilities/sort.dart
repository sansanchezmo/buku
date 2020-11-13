import 'package:buku/main_objects/mini_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sort{

  static int _compareDate(Timestamp t1, Timestamp t2){

    return t1.compareTo(t2);

  }

  static List<MiniBook> sortMiniBookByTimeStamp(List<Map<String, dynamic>> mini, {desc: true}){

    mini.sort((a,b) => _compareDate(a['date'], b['date']));

    List<MiniBook> list = [];

    for(Map<String, dynamic> map in mini){
      list.add(MiniBook(
        map['isbn'],
        map['title'],
        map['authors'],
        map['image_url']
      ));
    }

    if(desc) return list.reversed.toList();

    return list;
  }
}