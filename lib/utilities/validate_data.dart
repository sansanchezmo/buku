import 'package:buku/firebase/firestore.dart';

class ValidateData{
  static bool checkEmail(String email){
    int arroba = 0;
    if(email == '') return false;
    if(email[0] == '.' || email[email.length-1] == '.') return false;
    for(int i = 0; i< email.length;i++){
      if(email[i] == '@') arroba++;
    }

    if(arroba != 1) return false;
    return true;
  }

  static Future<List<bool>> validatingData(String email, String password, String name) async{

    bool boolEmail = checkEmail(email);
    bool boolPass = password.length >= 6;
    bool boolName = await Firestore().checkName(name);

    return [boolEmail, boolPass, boolName];

  }
}