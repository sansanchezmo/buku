import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/config_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'config_widgets/about_you.dart';
import 'config_widgets/choose_theme.dart';
import 'config_widgets/interesting_tags.dart';

class InitConfigScaffold extends StatefulWidget {
  _InitConfigScaffoldState createState() => _InitConfigScaffoldState();
}

class _InitConfigScaffoldState extends State<InitConfigScaffold> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  PageController controller = PageController();
  @override void initState() {
    ConfigCache.initCache();
    super.initState();
  }

  @override void dispose() {
    nameController.dispose();
    descController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: [
              ChooseTheme(),
              AboutYou(name: nameController,desc: descController,),
              InterestingTags(name: nameController,desc: descController,),
            ],
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: SwapEffect(dotColor: CurrentTheme.textColor2,activeDotColor: CurrentTheme.primaryColor,
                  dotHeight: 10, dotWidth: 10),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}