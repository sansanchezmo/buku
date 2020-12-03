import 'package:buku/theme/current_theme.dart';
import 'package:flutter/material.dart';

class MainPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
            gradient: CurrentTheme.primaryGradientColorVariant
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 90,
          decoration: BoxDecoration(
            color: CurrentTheme.background,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40)
            )
          ),
        ),
        Positioned(
          bottom: 10,
          child: Image(
            height: 60,
            width: 60,
            image: AssetImage(
              'assets/images/bukunobackgroundfull.PNG',
            ),
        ),)
      ],
    );
  }

}