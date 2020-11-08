class MiniUser{

  String _uid, _name, _nickname, _imagePath;

  String get uid => _uid;

  MiniUser(this._uid, this._name, this._nickname, this._imagePath);

  get name => _name;
  get nickname => _nickname;
  get imagePath => _imagePath;

  //TODO: implement toWidget method
}