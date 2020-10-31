import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'init_scaffolds/config_widgets/interesting_tags.dart';

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: InterestingTags()
    );
  }
}
