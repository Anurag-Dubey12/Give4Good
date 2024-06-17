import 'package:flutter/material.dart';

class CustomSliderThumb extends SliderComponentShape{
  late final double thumbRadius;
  late final IconData icon;
  CustomSliderThumb({required this.thumbRadius,required this.icon});
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }
  @override
  void paint(
      PaintingContext context,
      Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow})
  {
    final Canvas canvas=context.canvas;
    final paint=Paint()
      ..color=sliderTheme.thumbColor!
      ..style=PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, paint);
    final iconPainter=TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: thumbRadius,
            fontFamily: icon.fontFamily,
            package: icon.fontPackage,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr
    );
    iconPainter.layout();
    iconPainter.paint(
        canvas,
        center-Offset(iconPainter.width/2.0,iconPainter.height/2.0));
  }
}