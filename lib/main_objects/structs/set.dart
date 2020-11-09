import 'package:buku/main_objects/structs/linked_list.dart';

class UnorderedSet<T> {
  // For now I think the best is to use built-in hashes.
  // If you need hashes in objects without that property,
  // we can put that in the object.
  /*
  static const int _prime = 1000000007;
  static const int _multiplier = 263;
  */

  // public attributes - nothing here
  // private attributes
  int _size;
  int _tableSize;
  static const int _load_factor = 2;
  List _table;

  // public methods
  UnorderedSet() {
    try {
      T.hashCode;
    } catch(e) {
      throw Exception('UnorderedSet element has no hashCode property');
    }

    _size = 0;
    _tableSize = 4;
    _table = new List();

    for (int i = 0; i < _tableSize; i++)
      _table.add(new LinkedList<T>());
  }

  bool get isEmpty => _size == 0;
  int get length => _size;
  bool get single => _size == 1;

  bool contains(T val) => _table[val.hashCode % _tableSize].found(val);

  void add(T val) {
    if (_size >= _tableSize * _load_factor)
      _reHash();

    _table[val.hashCode % _tableSize].pushFront(val);
    _size++;
  }

  void addAll(Iterable<T> elements) {
    for (T element in elements)
      add(element);
  }

  bool remove(T val) {
    if (contains(val)) {
      _table[val.hashCode % _tableSize].eraseNode(val);
      _size--;
      return true;
    }
    else {
      return false;
    }
  }

  void removeAll(Iterable<T> elements) {
    for(T element in elements)
      remove(element);
  }

  void forEach(void f(T element)) {
    for (int i = 0; i < _tableSize; i++)
      for (Node itr = _table[i].front(); itr != null; itr = itr.next())
        f(itr.data());
  }

  // private methods
  void _reHash() {
    List newTable = new List();
    for (int i = 0; i < _tableSize * _load_factor; i++)
      newTable.add(new LinkedList<T>());

    for (int i = 0; i < _tableSize; i++)
      for (Node itr = _table[i].front(); itr != null; itr = itr.next())
        newTable[itr.data().hashCode % (_tableSize * _load_factor)].pushFront(itr.data());

    _table = newTable;
    _tableSize *= _load_factor;
  }
}

void main() {}
