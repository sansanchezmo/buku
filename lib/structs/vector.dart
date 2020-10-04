class Vector<T> {
  //public attributes - nothing here
  //private attributes
  List _data;
  int _size;
  int _capacity;
  static const int _min_capacity = 1;

  //public methods
  vector([int initialSize = 0, T filling]) {
    _size = 0;
    _capacity = _min_capacity;
    _data = new List(_capacity);
    resize(initialSize, filling);
  }

  operator [](int index) {
    if (0 <= index && index < _size)
      return _data[index];
    else
      throw IndexError(index, this, '', 'vector index out of range', size());
  }

  operator []=(int index, T val) {
    if (0 <= index && index < _size)
      _data[index] = val;
    else
      throw IndexError(index, this, '', 'vector assignment index out of range', size());
  }

  int size() {
    return _size;
  }

  bool empty() {
    return size() == 0;
  }

  void pushBack(T val) {
    if (_size == _capacity)
      _realloc(true);

    _data[_size] = val;
    _size++;
  }

  void insert(int index, T val) {
    if ( 0 > index || index > _size)
      throw IndexError(index, this, '', 'vector inserting index out of range', size());

    if (index == _size) {
      pushBack(val);
      return;
    }

    pushBack(null);

    for (int i = _size - 2; i >= index; --i)
      _data[i + 1] = _data[i];

    _data[index] = val;
  }

  T popBack() {
    if (empty())
      throw RangeError('pop from empty vector');

    _size--;
    T val = _data[_size];
    _data[_size] = null;

    if (4 * _size <= _capacity //the reallocating criteria
      && _capacity >= 2 * _min_capacity) //this avoids getting below minimal capacity
      _realloc(false);

    return val;
  }

  void erase(int index) {
    if (empty())
      throw RangeError('erase from empty vector');
    if (0 > index || index >= _size)
      throw IndexError(index, this, '', 'vector erasing index out of range', size());


    for (int i = index; i < _size - 1; i++)
      _data[i] = _data[i + 1];

    popBack();
  }

  void resize(int newSize, [T filling]) {
    if (newSize < 0)
      throw RangeError('new size must be non-negative');

    if (newSize <= _capacity) {
      if (_size <= newSize) {
        for (int i = _size; i < newSize; i++)
          _data[i] = filling;
      }
      else { //_size > newSize
        for (int i = newSize; i < _size; i++)
          _data[i] = null;
      }
    }
    else { //newSize > _capacity
      int newCapacity = 1;
      int count = 0;

      while (newSize >> count > 0) {
        newCapacity = newCapacity << 1;
        count++;
      }

      if (newSize << 1 == newCapacity)
        newCapacity = newSize;

      List newData = new List(newCapacity);

      for (int i = 0; i < _size; i++)
        newData[i] = _data[i];
      for (int i = _size; i < newSize; i++)
        newData[i] = filling;

      _data = newData;
      _capacity = newCapacity;
    }

    _size = newSize;
  }

  //private methods
  void _realloc(bool doubleCapacity) {
    if (doubleCapacity)
      _capacity *= 2;
    else
      _capacity ~/= 2;

    List newData = new List(_capacity);

    for (int i = 0; i < _size; i++)
      newData[i] = _data[i];

    _data = newData;
  }
}
