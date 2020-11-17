void siftDown(List arr, int length, int i) {
  int maxIndex = i;
  int left = 2 * i + 1;
  int right = 2 * i + 2;

  if (left < length && !(arr[left] <= arr[maxIndex]))
    maxIndex = left;
  if (right < length && !(arr[right] <= arr[maxIndex]))
    maxIndex = right;

  if (i != maxIndex) {
    var temp = arr[maxIndex];
    arr[maxIndex] = arr[i];
    arr[i] = temp;
    siftDown(arr, length, maxIndex);
  }
}

void heapSort(List arr) {
  for (int i = (arr.length ~/ 2) - 1; i >= 0; i--)
    siftDown(arr, arr.length, i);

  for (int i = arr.length - 1; i > 0; i--) {
    var temp = arr[0];
    arr[0] = arr[i];
    arr[i] = temp;
    siftDown(arr, i, 0);
  }
}

abstract class _Heap {
  // public attributes - nothing here
  // private attributes
  List _data;

  // public methods
  _Heap() {
    _data = new List();
  }

  bool empty() => _data.length == 0;

  void add(val) {
    _data.add(val);
    _siftUp(_data.length - 1);
  }

  // private methods
  dynamic _extract() {
    var val = _data[0];
    _data[0] = _data[_data.length - 1];
    _data.removeLast();
    _siftDown(0);

    return val;
  }

  int _parent(int i) => (i - 1) ~/ 2;
  int _left(int i) => 2 * i + 1;
  int _right(int i) => 2 * i + 2;

  bool _compare(a, b);

  void _siftUp(int i) {
    while (i > 0 && _compare(_data[_parent(i)], _data[i])) {
      var temp = _data[i];
      _data[i] = _data[_parent(i)];
      _data[_parent(i)] = temp;
      i = _parent(i);
    }
  }

  void _siftDown(int i) {
    int maxIndex = i;
    int left = _left(i);
    int right = _right(i);

    if (left < _data.length && _compare(_data[maxIndex], _data[left]))
      maxIndex = left;
    if (right < _data.length && _compare(_data[maxIndex], _data[right]))
      maxIndex = right;

    if (i != maxIndex) {
      var temp = _data[i];
      _data[i] = _data[maxIndex];
      _data[maxIndex] = temp;
      _siftDown(maxIndex);
    }
  }
}

class MaxHeap extends _Heap {
  //_compare(a, b) => (a <= b);
  _compare(a,b) => a.compareTo(b) == 0 ||a.compareTo(b) < 0;
  max() => _data[0];
  extractMax() {
    if (_data.length == 0)
      throw Exception('extractMax from empty heap');

    return _extract();
  }
}

class MinHeap extends _Heap {
  _compare(a, b) => !(a <= b);

  min() => _data[0];

  extractMin() {
    if (_data.length == 0)
      throw Exception('extractMin from empty heap');

    return _extract();
  }
}

void main() {}
