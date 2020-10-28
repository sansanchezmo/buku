import 'package:flutter/material.dart';
import 'package:buku/firebase/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class UserConfig extends StatefulWidget {
  _UserConfig createState() => _UserConfig();
}

class _UserConfig extends State<UserConfig> {
  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: [Slide(
        title: 'test i guess',
        description: 'hola aka estoy'
      )],

    );
  }
}