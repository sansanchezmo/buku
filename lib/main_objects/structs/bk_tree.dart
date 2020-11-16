import 'dart:math';

int editDistance(String str1, String str2) {
  int m = str1.length;
  int n = str2.length;
  List distance = List.generate(m + 1, (int index) => new List(n + 1));

  for (int i = 0; i <= m; i++) distance[i][0] = i;
  for (int j = 0; j <= n; j++) distance[0][j] = j;

  int a, b, c;
  for (int i = 1; i <= m; i++) {
    for (int j = 1; j <= n; j++) {
      a = distance[i][j - 1] + 1;

      b = distance[i - 1][j] + 1;

      c = distance[i - 1][j - 1];
      c += (str1[i - 1].toLowerCase() == str2[j - 1].toLowerCase()) ? 0 : 1;

      distance[i][j] = [a, b, c].reduce(min);
    }
  }

  return distance[m][n];
}

class BKTreeNode {
  String key;
  String data;
  List children;

  BKTreeNode(String theKey, String theData) {
    key = theKey;
    data = theData;
    children = new List();
  }
}

class BKTree {
  BKTreeNode _root;
  int _size;
  static const int tolerance = 1;

  BKTree() {
    _size = 0;
    _root = null;
  }

  int get length => _size;
  bool get isEmpty => _size == 0;

  bool add(BKTreeNode newNode) {
    if (isEmpty) {
      _root = newNode;
      _size++;
      return true;
    } // else...

    BKTreeNode theRoot = _root;
    while (true) {
      int d = editDistance(newNode.key, theRoot.key);
      if (d == 0) return false;

      d--;
      if (d < theRoot.children.length) {
        if (theRoot.children[d] == null) {
          theRoot.children[d] = newNode;
          _size++;
          return true;
        }
        else {
          theRoot = theRoot.children[d];
          continue;
        }
      }
      else {
        while (d >= theRoot.children.length)
          theRoot.children.add(null);

        theRoot.children[d] = newNode;
        _size++;
        return true;
      }
    }
  }

  void _suggestionsHelper(String query, List suggestions, BKTreeNode theRoot) {
    if (theRoot == null) return;

    int d = editDistance(query, theRoot.key);
    if (d == 0) {
      suggestions.insert(0, [theRoot.key, theRoot.data]);
      return;
    }
    else if (d <= tolerance) suggestions.add([theRoot.key, theRoot.data]);

    int start = [0, d - tolerance - 1].reduce(max);
    int end = [theRoot.children.length, d + tolerance].reduce(min);

    while (start < end) {
      _suggestionsHelper(query, suggestions, theRoot.children[start]);
      start++;
    }
  }

  List searchSuggestions(String query) {
    List suggestions = new List();
    _suggestionsHelper(query, suggestions, _root);
    return suggestions;
  }
}

void main() {
  /*
  BKTree A = new BKTree();
  List s = ["aardvark","aardvarks","abaci","aback","abacus","abacuses","abaft","abalone","abalones","abandon","abandoned","abandoning","abandonment","abandons","abase","abased","abasement","abases","abash","abashed","abashes","abashing","abasing","abate","abated","abatement","abates","abating","abattoir","abattoirs","abbess","abbesses","abbey","abbeys","abbot","abbots","abbreviate","abbreviated","abbreviates","abbreviating","abbreviation","abbreviations","abdicate","abdicated","abdicates","abdicating","abdication","abdications","abdomen","abdomens","abdominal","abduct","abducted","abducting","abduction","abductions","abductor","abductores","abductors","abducts","abeam","abed","aberrant","aberration","aberrations","abet","abets","abetted","abetter","abetters","abetting","abettor","abettors","abeyance","abhor","abhorred","abhorrence","abhorrent","abhorring","abhors","abide","abided","abides","abiding","abidings","abilities","ability","abject","abjected","abjecting","abjectly","abjects","abjuration","abjurations","abjure","abjured","abjures","abjuring","ablative","ablatives","ablaze","able","abler","ables","ablest","abloom","ablution","ablutions","ably","abnegate","abnegated","abnegates","abnegating","abnegation","abnormal","abnormalities","abnormality","abnormally","aboard","abode","aboded","abodes","aboding","abolish","abolished","abolishes","abolishing","abolition","abolitionist","abolitionists","abominable","abominably","abominate","abominated","abominates","abominating","abomination","abominations","aboriginal","aboriginals","aborigine","aborigines","abort","aborted","aborting","abortion","abortionist","abortionists","abortions","abortive","aborts","abound","abounded","abounding","abounds","about","abouts","above","aboveboard","abracadabra","abrade","abraded","abrades","abrading","abrasion","abrasions","abrasive","abrasively","abrasiveness","abrasives","abreast","abridge","abridged","abridgement","abridgements","abridges","abridging","abridgment","abridgments","abroad","abrogate","abrogated","abrogates","abrogating","abrogation","abrogations","abrupt","abrupter","abruptest","abruptly","abruptness","abscess","abscessed","abscesses","abscessing","abscissa","abscissae","abscissas","abscond","absconded","absconding","absconds","absence","absences","absent","absented","absentee","absenteeism","absentees","absenting","absently","absents","absinth","absinthe","absolute","absolutely","absoluter","absolutes","absolutest","absolution","absolutism","absolve","absolved","absolves","absolving","absorb","absorbed","absorbency","absorbent","absorbents","absorbing","absorbs","absorption","abstain","abstained"];
  print(s.length);
  int start = DateTime.now().millisecondsSinceEpoch;
  for (int i = 0; i < s.length; i++)
    A.add(new BKTreeNode(s[i], ""));
  print((DateTime.now().millisecondsSinceEpoch - start) / 1000);

  start = DateTime.now().millisecondsSinceEpoch;
  var x = A.searchSuggestions("abac");
  print((DateTime.now().millisecondsSinceEpoch - start) / 1000);
  print(x);
  */
}
