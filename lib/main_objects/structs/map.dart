import 'package:buku/main_objects/structs/linked_list.dart';

class Pair<K, V> {
  K first;
  V last;
  Pair(this.first, this.last);

  @override
  bool operator== (Object other) => this.first == other;
}

class UnorderedMap<K, V> {
  // public attributes - nothing here
  // private attributes
  int _size;
  int _tableSize;
  static const int _load_factor = 2;
  List _table;

  // public methods
  UnorderedMap() {
    _size = 0;
    _tableSize = 4;
    _table = new List(_tableSize);

    for (int i = 0; i < _tableSize; i++)
      _table[i] = new LinkedList<Pair<K, V>>();
  }

  int get length => _size;
  bool get single => _size == 1;
  bool get isEmpty => _size == 0;

  V operator[] (K key) {
    var itr = _table[key.hashCode % _tableSize].foundNode(key);
    if (itr == null) return null;
    else return itr.data().last;
  }

  void operator[]= (K key, V value) {
    var itr = _table[key.hashCode % _tableSize].foundNode(key);

    if (itr == null) {
      if (_size >= _tableSize * _load_factor)
        _reHash();

      _table[key.hashCode % _tableSize].pushFront(new Pair(key, value));
      _size++;
    }
    else
      itr.data().last = value;
  }

  bool contains(K val) => _table[val.hashCode % _tableSize].found(val);

  bool remove(K val) {
    if (!contains(val))
      return false;

    _table[val.hashCode % _tableSize].eraseNode(val);
    _size--;
    return true;
  }

  void forEach(void f(K key, V value)) {
    for (int i = 0; i < _tableSize; i++)
      for (Node itr = _table[i].front(); itr != null; itr = itr.next())
        f(itr.data().first, itr.data().last);
  }

  // private methods
  void _reHash() {
    List newTable = new List(_tableSize * _load_factor);
    for (int i = 0; i < _tableSize * _load_factor; i++)
      newTable[i] = new LinkedList<Pair<K, V>>();

    for (int i = 0; i < _tableSize; i++)
      for (Node itr = _table[i].front(); itr != null; itr = itr.next())
        newTable[itr.data().first.hashCode % (_tableSize * _load_factor)].pushFront(itr.data());

    _table = newTable;
    _tableSize *= _load_factor;
  }
}

void main() {
  /*
  var D = new UnorderedMap<String, int>();
  for (int i = 0; i < 16; i++)
    D[i.toString()] = i + 1;
  for (int i = 0; i < 16; i++)
    print(D[i.toString()]);
  */
}
