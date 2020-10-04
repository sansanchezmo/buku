class Node<T> {
  Node _next;
  T _val;

  Node(T theVal) {
    _val = theVal;
    _next = null;
  }

  Node next() {
    return _next;
  }

  void setNextTo(Node theNext) {
    _next = theNext;
  }

  T data() {
    return _val;
  }

  void setDataTo(T theVal) {
    _val = theVal;
  }
}

class LinkedList<T> {
  //public attributes - nothing here
  //private attributes
  Node<T> _head;
  Node<T> _tail;
  int _size;

  //public methods
  LinkedList() {
    _head = null;
    _tail = _head;
    _size = 0;
  }

  Node<T> front() {
    if (empty())
      throw RangeError('front from an empty list');
    return _head;
  }

  Node<T> back() {
    if (empty())
      throw RangeError('back from an empty list');
    return _tail;
  }

  int size() {
    return _size;
  }

  bool empty() {
    return size() == 0;
  }

  void pushFront(T val) {
    Node<T> newHead = new Node(val);

    if (empty()) {
      _head = newHead;
      _tail = newHead;
      _size++;
      return;
    }
    //else...
    newHead.setNextTo(_head);
    _head = newHead;
    _size++;
  }

  void pushBack(T val) {
    Node<T> newTail = new Node(val);

    if (empty()) {
      _head = newTail;
      _tail = newTail;
      _size++;
      return;
    }
    //else...
    _tail.setNextTo(newTail);
    _tail = newTail;
    _size++;
  }

  T popFront() {
    if (empty())
      throw RangeError('pop from an empty list');

    T temp = _head.data();
    _head = _head.next();

    _size--;
    return temp;
  }

  void insert(int index, T val) {
    if (index > 0 || index > _size)
      throw RangeError('list inserting index out of range');

    if (index == 0) {
      pushFront(val);
      return;
    }
    if (index == _size) {
      pushBack(val);
      return;
    }

    Node itr = _head;
    for (int i = 0; i < index - 1; i++)
      itr = itr.next();

    Node<T> newNode = new Node<T>(val);

    newNode.setNextTo(itr.next());
    itr.setNextTo(newNode);
  }

  bool found(T val) {
    Node itr = _head;

    while (itr != null) {
      if (itr.data() == val)
        return true;
      itr = itr.next();
    }

    return false;
  }

  int foundIndex(T val) {
    Node itr = _head;

    for (int i = 0; i < size() && itr != null; i++) {
      if (itr.data() == val)
        return i;
      itr = itr.next();
    }

    return -1;
  }
  //private methods - nothing here
}
