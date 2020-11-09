
import 'package:buku/main_objects/main_user.dart';

class ConfigCache{

  static String _theme;
  static String _name;
  static String _description;
  static String _userImageUrl;
  static List<String> _tags;

  static initCache(){
    _theme = _theme = _name = _description = _userImageUrl = '';
    _tags = List<String>();
  }

  static storeCache() async{

     await MainUser.storeMainData(_theme, _name, _description, _userImageUrl, _tags);

  }

  static bool nameEmpty() => _name=='';
  static bool descriptionEmpty() => _description=='';

  static String get theme => _theme;

  static set theme(String value) {
    _theme = value;
  }

  static String get name => _name;

  static set name(String value) {
    _name = value;
  }

  static String get description => _description;

  static set description(String value) {
    _description = value;
  }

  static String get userImageUrl => _userImageUrl;

  static set userImageUrl(String value) {
    _userImageUrl = value;
  }

  static List<String> get tags => _tags;

  static set tags(List<String> value) {
    _tags = value;
  }

}