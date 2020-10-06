import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget{
  final IconData icon;
  final double size;
  final Gradient gradient;
  static const defaultGradient = LinearGradient(
      colors: [Colors.orange,Colors.deepOrange]
  );

  const GradientIcon({Key key, @required this.icon, @required this.size, this.gradient = defaultGradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: this.size * 1.2,
        height: this.size * 1.2,
        child: Icon(
          this.icon,
          color: Colors.white,
          size: this.size,
        ),
      ),
      shaderCallback: (Rect bounds){
        final Rect rect = Rect.fromLTRB(0, 0, this.size, this.size);
        return this.gradient.createShader(rect);
      },
    );
  }
}