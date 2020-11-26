import 'package:buku/main_objects/structs/map.dart';
import 'dart:math';

class TrieNode {
  bool isLeaf;
  String key;
  UnorderedMap<String, TrieNode> children;

  TrieNode([bool leaf = false, String theKey]) {
    isLeaf = leaf;
    key = theKey;
    children = new UnorderedMap<String, TrieNode>();
  }
}

class Trie {
  TrieNode _root;

  Trie() {
    _root = new TrieNode();
  }

  void add(String str, [String key = ""]) {
    TrieNode theRoot = _root;
    for (int i = 0; i < str.length; i++) {
      String chr = str[i].toLowerCase();
      if (theRoot.children[chr] == null) {
        TrieNode newNode;
        if (i == str.length - 1) newNode = new TrieNode(true, key);
        else newNode = new TrieNode();

        theRoot.children[chr] = newNode;
      }
      theRoot = theRoot.children[chr];
    }
  }

  void _prefixSearchHelper(TrieNode theRoot, List sugs, String curStr) {
    if (theRoot == null) return;

    if (theRoot.isLeaf) {
      sugs.add([curStr, theRoot.key]);
    }

    theRoot.children.forEach((mapKey, mapValue) {
      _prefixSearchHelper(mapValue, sugs, curStr + mapKey);
    });
  }

  List prefixSearch(String str) {
    TrieNode theRoot = _root;
    String substr = "";
    int i = 0;

    for (int i = 0; i < str.length; i++) {
      String chr = str[i].toLowerCase();
      if (theRoot.children[chr] == null)
        return [];

      theRoot = theRoot.children[chr];
      substr += str[i];
    }

    List sugs = new List();
    _prefixSearchHelper(theRoot, sugs, substr);
    return sugs;
  }
}
/*
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

List randomStrings(int x, int length) {
  List a = new List();
  while (x-- > 0)
    a.add(getRandomString(length));
  return a;
}

Trie randomTrie(int elems) {
  Trie theTrie = new Trie();
  List theStrs = randomStrings(elems, 30);
  for (int i = 0; i < elems; i++)
    theTrie.add(theStrs[i]);
  return theTrie;
}

int randomTrieTime(int elems) {
  Trie theTrie = new Trie();
  List theStrs = randomStrings(elems, 30);
  int start = DateTime.now().microsecondsSinceEpoch;
  for (int i = 0; i < elems; i++)
    theTrie.add(theStrs[i]);
  int end = DateTime.now().microsecondsSinceEpoch;
  return end - start;
}

void testTrieSearch(int limit, bool unique) {
  print("Creating trie...");
  Trie bookTrie = randomTrie(500000);
  print("Done.");
  List a = new List();
  print("Calculating...");
  int jump = limit ~/ 100;
  int j = 1;
  if (!unique) {
    for (int i = jump; i <= limit; i += jump) {
      List queries = randomStrings(i, 15);

      int start = DateTime
          .now()
          .microsecondsSinceEpoch;
      for (int j = 0; j < i; j++)
        bookTrie.prefixSearch(queries[j]);
      int end = DateTime
          .now()
          .microsecondsSinceEpoch;
      a.add([i, end - start]);
      print((i * 100) ~/ limit);
    }
  }
  else {
    List queries = randomStrings(limit, 15);

    int start = DateTime
        .now()
        .microsecondsSinceEpoch;
    for (int j = 0; j < limit; j++)
      bookTrie.prefixSearch(queries[j]);
    int end = DateTime
        .now()
        .microsecondsSinceEpoch;
    a.add([limit, end - start]);
    print(++j);
  }
  print(a);
}

void testTrieCreate(int limit, bool unique) {
  List a = new List();
  print("Calculating...");
  int jump = limit ~/ 100;
  if (!unique) {
    for (int i = jump; i <= limit; i += jump) {
      a.add([i, randomTrieTime(i)]);
      print((i * 100) ~/ limit);
    }
  }
  else {
    a.add([limit, randomTrieTime(limit)]);
  }
  print(a);
}

void main() {
  //testTrieSearch(1000000, false);
  //testTrieSearch(10000000, true); //[[10000000, 15867304]]
  testTrieCreate(1000, true);
}
*/