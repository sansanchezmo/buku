import 'vector.dart';
import 'linked_list.dart';

class ArrayStack<T> {
  Vector<T> _arr;

  ArrayStack() {
    _arr = new Vector<T>();
  }

  bool empty() {
    return _arr.empty();
  }

  T top() {
    if (empty())
      throw RangeError('top from empty stack');
    return _arr[_arr.size() - 1];
  }

  void push(T val) {
    _arr.pushBack(val);
  }

  T pop() {
    if (empty())
      throw RangeError('pop from empty stack');
    return _arr.popBack();
  }
}

class ListStack<T> {
  LinkedList<T> _list;

  ListStack() {
    _list = new LinkedList<T>();
  }

  bool empty() {
    return _list.empty();
  }

  T top() {
    if (empty())
      throw RangeError('top from empty stack');
    return _list.front().data();
  }

  void push(T val) {
    _list.pushFront(val);
  }

  T pop() {
    if (empty())
      throw RangeError('pop from empty stack');
    return _list.popFront();
  }
}


class Stack<T> extends ListStack<T>{}
