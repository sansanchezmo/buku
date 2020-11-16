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
    /*
    if (empty())
      throw RangeError('front from an empty list');
    */
    return _head;
  }

  Node<T> back() {
    /*
    if (empty())
      throw RangeError('back from an empty list');
    */
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
      throw RangeError('popFront from empty list');

    T temp = _head.data();
    _head = _head.next();
    _size--;

    return temp;
  }

  T popBack() {
    if (empty())
      throw RangeError('popBack from empty list');

    return erase(_size - 1);
  }

  void insert(int index, T val) {
    if (!(0 <= index && index <= _size))
      throw IndexError(index, this, '', 'list inserting index out of range', size() + 1);

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
    _size++;
  }

  T erase(int index) {
    if (!(0 <= index && index < _size))
      throw IndexError(index, this, '', 'list erasing index out of range', size());

    if (index == 0) {
      return popFront();
    }

    Node itr = _head;
    for (int i = 0; i < index - 1; i++)
      itr = itr.next();

    if (index == _size - 1)
      _tail = itr;

    Node temp = itr.next();
    itr.next().setNextTo(itr.next().next());
    _size--;

    return temp.data();
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

  Node foundNode(val) {
    Node itr = _head;

    while (itr != null) {
      if (itr.data() == val)
        return itr;
      itr = itr.next();
    }

    return null;
  }

  bool eraseNode(T val) {
    Node itr = _head;

    if (empty())
      return false;

    if (itr.data() == val) {
      popFront();
      return true;
    }

    while (itr.next() != null) {
      if (itr.next().data() == val) {
        itr.setNextTo(itr.next().next());
        _size--;
        return true;
      }
      itr = itr.next();
    }

    return false;
  }
  //private methods - nothing here
}
