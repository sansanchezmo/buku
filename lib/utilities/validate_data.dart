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

  static Future<List<dynamic>> checkName(String name) async {

    String validCharacters = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz_0123456789. ';

    if(name == ''){
      return[false, 'that´s empty :v'];
    }

    for(int i=0; i< name.length; i++){
      if(!validCharacters.contains(name[i])){
        return [false, 'there are some weird characters :c'];
      }
    }
    for(int i=0; i< name.length; i++){
      if(name[i] == ' '){
        return [false,'I do not accept empty spaces'];
      }
    }

    bool boolName = await Firestore().checkName(name);

    return [boolName, 'name already taken'];

  }

  static Future<List<dynamic>> validatingData(String email, String password, String name) async{

    bool boolEmail = checkEmail(email);
    bool boolPass = password.length >= 6;
    List<dynamic> list = await checkName(name);

    return [boolEmail, boolPass, list[0], list[1]];

  }
}