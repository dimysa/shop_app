import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([onChanged]) {
    return new _CustomPainter(onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  _CustomPainter(VoidCallback onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(10.0)), paint);
  }
}
