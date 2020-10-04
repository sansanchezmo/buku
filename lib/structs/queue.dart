import 'linked_list.dart';

class ArrayQueue<T> {
  //public attributes - nothing here
  //private attributes
  int _headIndex;
  int _tailIndex;
  int _size;
  int _capacity;
  List _data;
  static final int _min_capacity = 1;

  //public methods
  ArrayQueue() {
    _size = 0;
    _headIndex = 0;
    _tailIndex = 0;
    _capacity = _min_capacity;
    _data = new List(_capacity);
  }

  bool empty() {
    return _size == 0;
  }

  T front() {
    if (empty())
      throw RangeError('front from empty queue');
    return _data[_headIndex];
  }

  void push(T val) {
    if (_size == _capacity)
      _realloc(true);

    _tailIndex = (_tailIndex + 1) % _capacity;
    _data[_tailIndex] = val;
    _size++;
  }

  T pop() {
    if (empty())
      throw RangeError('pop from empty queue');

    T temp = _data[_headIndex];
    _data[_headIndex] = null;
    _headIndex = (_headIndex + 1) % _capacity;
    _size--;

    //the same criteria as vector class
    if (4 * _size <= _capacity
        && _capacity >= 2 * _min_capacity)
      _realloc(false);

    return temp;
  }

  //private methods
  void _realloc(bool double_capacity) {
    int newCapacity;
    if (double_capacity)
      newCapacity = _capacity * 2;
    else
      newCapacity = _capacity ~/ 2;

    List newData = new List(newCapacity);

    for (int i = 0; i < _size; i++)
      newData[i] = _data[(_headIndex + i) % _capacity];

    _headIndex = 0;
    _tailIndex = _size - 1;
    _data = newData;
    _capacity = newCapacity;
  }
}

class ListQueue<T> {
  LinkedList<T> _list;

  ListQueue() {
    _list = new LinkedList<T>();
  }

  bool empty() {
    return _list.empty();
  }

  T front() {
    if (empty())
      throw RangeError('front from empty queue');
    return _list.front().data();
  }

  void push(T val) {
    _list.pushBack(val);
  }

  T pop() {
    if (empty())
      throw RangeError('pop from empty queue');
    return _list.popFront();
  }
}

class queue<T> extends ListQueue<T> {}
