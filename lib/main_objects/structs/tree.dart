import 'package:buku/main_objects/mini_book.dart';

class TreeNode<T> {
  TreeNode<T> parent;
  List children;
  T data;

  TreeNode([theData, TreeNode<T> theParent]) {
    data = theData;
    parent = theParent;
    children = new List();
  }
}

class Tree<T> {
  TreeNode<T> root;

  Tree() {
    root = new TreeNode<T>();
  }
}

// Alternative: Use only the class below. The root would be a BookListComponent.
class BookListComponent {
  BookListComponent parent;
  List children;
  String name;

  BookListComponent(BookListComponent theParent, String theName) {
    parent = theParent;
    children = new List();
    name = theName;
  }

  bool get isEmpty => children.isEmpty;
}

void main() {}
